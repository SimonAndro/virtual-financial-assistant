
from multiprocessing import context
from django.shortcuts import render, redirect
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User
from django.contrib import messages
from django.contrib.auth.decorators import login_required

from vfa.models import Account

from .forms import AccountForm
# Create your views here.

def loginPage(request):
    page = 'login'
    if request.user.is_authenticated:
        return redirect('user-dashboard')
    if request.method == 'POST':
        user_name = request.POST.get('username')
        user_password = request.POST.get('password')
        
        try:
            user = User.objects.get(username=user_name)
        except:
            messages.error(request, "User does not exist")
        
        user = authenticate(request, username=user_name, password=user_password)
        
        if user is not None:
            login(request, user)
            return redirect('user-dashboard', user.id)
        else:
            messages.error(request, "Username or password incorrect!")
    context = {'page': page}
    return render(request, 'vfa/login_register.html', context)

def registerPage(request):
    form = UserCreationForm()
    account_form = AccountForm()
    if request.method == 'POST':
        form = UserCreationForm(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            account = form.save(commit=False)
            user.username = user.username
            user.save()
            account.save()
            login(request, user)
            return redirect('user-dashboard')
    context = {'user_form':form, 'account_form':account_form}
    return render(request, 'vfa/login_register.html', context)


def logoutUser(request):
    logout(request)
    return redirect('home')

def home(request):
    return render(request, 'vfa/home.html')

def services(request):
    return render(request, 'vfa/services.html')

def stockMarket(request):
    return render(request, 'vfa/stock_market.html')

@login_required(login_url='login')
def userDashboard(request, pk):
    user = request.user
    account = Account.objects.get(id=pk)
    context = {'user':user, 'account':account}
    return render(request, 'vfa/user_dashboard.html', context)

@login_required(login_url='chat')
def aiChat(request):
    context = {}
    return render(request, 'vfa/chat.html', context)