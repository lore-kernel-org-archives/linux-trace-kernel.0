Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Qu+5hXto"
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786881B2
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:26:02 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cdcd790f42so2305652b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701451562; x=1702056362; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vq+yZNYl8Lw2AUOSy4g6/bjYdl5fMLDW5AHo/+FZIVE=;
        b=Qu+5hXtoVC/Q5P+L4kulPTP0eiESk8MA6B9nMhkmIs9xkIm+9a0rlphfzHUhldg51N
         n4AbKSoWW+SVCllaUf3DIv+/95u8Jq6nrNtlwI94nlHz7QSSSKMSryD+MqV5AOEYGO1y
         Lfw/JIQ4VtkUkMXjW8fSfFX32eIaZUX0qFNPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451562; x=1702056362;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vq+yZNYl8Lw2AUOSy4g6/bjYdl5fMLDW5AHo/+FZIVE=;
        b=Q+oxMZkBbIAr3zIoN6nPhdL8dKLlK1Ch+PqfmBZWlx2LYxkFgG2AQxeeB4ACXR1kUP
         nfdXXbof5xB7Q/7Zq2Dxj1DXal/jFiGETPpAhRrKYckCsm4S4ChRgOsgCwLedIjIk1IR
         X5IE4TWUP5J8HqQA2M3gKa3aXM0uKZAwIx+fGYfhJBBdspbOe1/vLLgSndSVKsmjhRTF
         QOSOKQ59COF2qxdzLmWO5+J0lU/mtdMqM7qUqrMyYsVJ2zKzJotAW8tjdlJk2FzfIhms
         IIF6Jpc1UyCltJksgX7W5oIYG6PSTjOgl38lN0rF2cJlbYjfqqNCiYc3qcG1y/zJ1Kgd
         jK5Q==
X-Gm-Message-State: AOJu0Yw1M5vZbmuqYxw+cH4iSDmeqZ91/UHTQhU8PAnEnNfrhPN/X7S9
	sgYnYzJ7+H2Ow2XroAbNUyU95HHuMVL+ueUrA3jvJA==
X-Google-Smtp-Source: AGHT+IHmJGmU0BBLhp+CXOjBU9rw0X1aNtKV54hoD+oDWcNhWoHqNmkXIMHDrWtXmsZtHVLvtCyGdw==
X-Received: by 2002:a05:6a00:2e19:b0:6cb:a431:2d75 with SMTP id fc25-20020a056a002e1900b006cba4312d75mr30495566pfb.7.1701451561355;
        Fri, 01 Dec 2023 09:26:01 -0800 (PST)
Received: from [192.168.86.33] ([136.52.74.64])
        by smtp.gmail.com with ESMTPSA id o10-20020a056a00214a00b006cbb40669b1sm3235402pfk.23.2023.12.01.09.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 09:26:00 -0800 (PST)
Message-ID: <81af85b4-5274-4362-9413-890425c60524@broadcom.com>
Date: Fri, 1 Dec 2023 09:25:59 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ARM Ftrace Function Graph Fails With UNWINDER_FRAME_POINTER
To: Ard Biesheuvel <ardb@kernel.org>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
 linux@armlinux.org.uk, linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Doug Berger <doug.berger@broadcom.com>
References: <d870c149-4363-43de-b0ea-7125dec5608e@broadcom.com>
 <CAMj1kXGST7uH530hB0i-rzisNesNrUGsJ5a5eC9805Udi5msrQ@mail.gmail.com>
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <CAMj1kXGST7uH530hB0i-rzisNesNrUGsJ5a5eC9805Udi5msrQ@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f86382060b760f7f"

--000000000000f86382060b760f7f
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/1/2023 1:12 AM, Ard Biesheuvel wrote:
> On Fri, 1 Dec 2023 at 00:48, Justin Chen <justin.chen@broadcom.com> wrote:
>>
>> Hello,
>>
>> Ran into an odd bug that I am unsure what the solution is. Tested a few
>> kernels versions and they all fail the same.
>>
>> FUNCTION_GRAPH_FP_TEST was enabled with 953f534a7ed6 ("ARM: ftrace:
>> enable HAVE_FUNCTION_GRAPH_FP_TEST"). This test fails when
>> UNWINDER_FRAME_POINTER is enabled. Enable function_graph tracer and you
>> should see a failure similar to below.
>>
>> [   63.817239] ------------[ cut here ]------------
>> [   63.822006] WARNING: CPU: 3 PID: 1185 at kernel/trace/fgraph.c:195
>> ftrace_return_to_handler+0x228/0x374
>> [   63.831645] Bad frame pointer: expected d1e0df40, received d1e0df48
>> [   63.831645]   from func packet_setsockopt return to c0b558f4
>> [   63.843801] Modules linked in: bdc udc_core
>> [   63.848246] CPU: 3 PID: 1185 Comm: udhcpc Not tainted
>> 6.1.53-0.1pre-gf0bc552d12f8 #33
>> [   63.856209] Hardware name: Broadcom STB (Flattened Device Tree)
>> [   63.862227] Backtrace:
>> [   63.864761]  dump_backtrace from show_stack+0x20/0x24
>> [   63.869982]  r7:c031cd8c r6:00000009 r5:00000013 r4:c11c7fac
>> [   63.875736]  show_stack from dump_stack_lvl+0x48/0x54
>> [   63.880929]  dump_stack_lvl from dump_stack+0x18/0x1c
>> [   63.886111]  r5:000000c3 r4:c11bd92c
>> [   63.889764]  dump_stack from __warn+0x88/0x130
>> [   63.894339]  __warn from warn_slowpath_fmt+0x140/0x198
>> [   63.899631]  r8:d1e0deac r7:c11bd958 r6:c031cd8c r5:c11bd92c r4:00000000
>> [   63.906431]  warn_slowpath_fmt from ftrace_return_to_handler+0x228/0x374
>> [   63.913294]  r8:c3a8d840 r7:00000002 r6:d1e0df48 r5:c2377a94 r4:c269a400
>> [   63.920095]  ftrace_return_to_handler from return_to_handler+0xc/0x18
>> [   63.926699]  r8:c0cd8ed0 r7:00000008 r6:c418c500 r5:00000004 r4:00000107
>> [   63.933500]  __sys_setsockopt from return_to_handler+0x0/0x18
>> [   63.939415]  r8:c02002bc r7:00000126 r6:00000003 r5:00000000 r4:00000004
>> [   63.946217]  sys_setsockopt from return_to_handler+0x0/0x18
>> [   63.952053] ---[ end trace 0000000000000000 ]---
>>
>> Sure enough the top of the parent stack is off by 8. (Tested with
>> gcc6.3/gcc8.3/gcc12.3)
>> 00006dcc <packet_setsockopt>:
>>       6dcc:       e1a0c00d        mov     ip, sp
>>       6dd0:       e24dd008        sub     sp, sp, #8 <======
>>       6dd4:       e92ddff0        push    {r4, r5, r6, r7, r8, r9, sl,
>> fp, ip, lr, pc}
>>       6dd8:       e24cb00c        sub     fp, ip, #12
>>       6ddc:       e24dd06c        sub     sp, sp, #108    @ 0x6c
>>       6de0:       e52de004        push    {lr}            @ (str lr, [sp,
>> #-4]!)
>>       6de4:       ebfffffe        bl      0 <__gnu_mcount_nc>
>>
>> I'm not quite sure why gcc is putting this extra 8 byte frame (maybe
>> some optimization?), but it isn't being accounted for thus the
>> FUNCTION_GRAPH_FP_TEST for arm fails. Note that only some functions do
>> this. Function graph works with FUNCTION_GRAPH_FP_TEST disabled, so it
>> looks the test is hitting false positives.
>>
> 
> Thanks for the report.
> 
> It appears the sub instruction at 0x6dd0 correctly accounts for the
> extra 8 bytes, so the frame pointer is valid. So it is our assumption
> that there are no gaps between the stack frames is invalid.

Thanks for the assistance. The gap between the stack frame depends on 
the function. Most do not have a gap. Some have 8 (as shown above), some 
have 12. A single assumption here is not going to work. I'm having a 
hard time finding out the reasoning for this gap. I tried disabling a 
bunch of gcc flags as well as -O2 and the gap still exists.

Thanks,
Justin

> 
> Could you try the following change please?
> 
> --- a/arch/arm/kernel/ftrace.c
> +++ b/arch/arm/kernel/ftrace.c
> @@ -235,8 +235,12 @@
>                  return;
> 
>          if (IS_ENABLED(CONFIG_UNWINDER_FRAME_POINTER)) {
> -               /* FP points one word below parent's top of stack */
> -               frame_pointer += 4;
> +               /*
> +                * The top of stack of the parent is recorded in the stack
> +                * frame at offset [fp, #-8].
> +                */
> +               get_kernel_nofault(frame_pointer,
> +                                  (unsigned long *)(frame_pointer - 8));
>          } else {
>                  struct stackframe frame = {
>                          .fp = frame_pointer,

--000000000000f86382060b760f7f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
NhTY3E+cXCB11wty89QStajwXdhGJTYEvUgvsq1h8CwJj9w/38ldAQf5WjhPmApYeJR2ewFrBMCM
4lHkdRJ6TDc9nXoEkypUfjJkJHe7Eal06tosh6JpAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGGp1c3Rpbi5jaGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUIWGeYuaTsnIada5Xx8TR3cheUbgw
DQYJKoZIhvcNAQELBQADggEBAHNQlMqQOFYPYFO71A+8t+qWMmtOdd2iGswSOvpSZ/pmGlfw8ZvY
dRTkl27m37la84AxRkiVMes14JyOZJoMh/g7fbgPlU14eBc6WQWkIA6AmNkduFWTr1pRezkjpeo6
xVmdBLM4VY1TFDYj7S8H2adPuypd62uHMY/MZi+BIUys4uAFA+N3NuUBNjcVZXYPplYxxKEuIFq6
sDL+OV16G+F9CkNMN3txsym8Nnx5WAYZb6+rBUIhMGz70V05xsHQfzvo2s7f0J1tJ5BoRlPPhL0h
VOnWA3h71u9TfSsv+PXVm3P21TfOS2uc1hbzEqyENCP4i5XQ0rv0TmPW42GZ0o4xggJtMIICaQIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwj8BKLXNpALfemdRAwDQYJ
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKhG047HewzTrKlsFqRrFedqs7ZFc4GB9ye5
uEPITZqgMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIwMTE3
MjYwMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQAK/0FzgB8S5KLhjkSPJybgqwt2ZT9m9F6JKbJCnuiWrVL//mP06zkw
RBn7gw+DU5ONK4Q2IdQO+PHap0sQJGMzhpvGF44ezPUtucV/Bl8yWsacr+u1JKBiq1di9MTn0E8P
ZfEkGRM+EAbkJrNF0jjacYmXD3AWl5l71V/ZBNJWNeVsp3xpJPP2wBcXvTA2hE2seYFZGz6LN2FM
oD1uUZBJbFhzM0w17eAVaD/9pKbfHsQD4prnDjpa5VEuSMeFHHs+DP+/8tSM0O5g6CEGzipC/nTR
yYDkdwhyJg0MgRWySTw+VLqoyJjfPpyBEoAWj7UGydinheI3omi0CCJwti0o
--000000000000f86382060b760f7f--
