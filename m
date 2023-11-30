Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y+aK+Kdz"
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D10129
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:47:58 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-28659b38bc7so34739a91.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701388078; x=1701992878; darn=vger.kernel.org;
        h=cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=et4sI3OfgPZYzP7KJd0xMrDM3g2RNnX2W3hPOnOQh/0=;
        b=Y+aK+KdzxErpZwF6ThIWk3Qw6M5uo3YWkZL+xxL/m30OsrWIAFJwS7mCkWrhu01A4N
         7t3e9zP8m4U+Xm10GNYZ2xk5C3i+LdCStFhqg1QvrwOc2450cx02b0q+u8C30nUTE5E9
         wpbqpAy2MpN+0YEJaSSkMkS/OhxK6EB4u2rHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701388078; x=1701992878;
        h=cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=et4sI3OfgPZYzP7KJd0xMrDM3g2RNnX2W3hPOnOQh/0=;
        b=mgaRIWwhqy+2P1I0jM4knJljJcq5QemBJj+B1HUO0HP9DP6sYa/F2I5+YRdTjntLeN
         +MpWJJ1b2dA5pNxCZJf7SZL5pX+kGdn/QIW9dydDGSMw1gD2Dp6O+d3bBRRKU6JjLo6n
         D3j9OY9jYWDZoSH2GZ3pp3DbBTKRDdn0gWhjcl4V6zqB6MwK9xw3UJbyvChd4IbW+k5y
         SeqBHN4XFQhg9XPR1Vfkq6OirekOUsUNNhzVJ2pAYFSumgC4Wy9I4as7nmM5QUpDvVEQ
         NHT5xfDtQraW8IXGmkSj+Kcq5fA6X/UDwgO1R6SlHxvJbYjq1Xn0xvSIv9aff25fvHqK
         zogw==
X-Gm-Message-State: AOJu0YxEn/r1wDIvRpQ///CIZmtazXrNE6oGAssB/Rh9CBkBMUwymJJ1
	lvERTmzmi6YT8ZiWunjElX2D4g==
X-Google-Smtp-Source: AGHT+IGLi5BOcEVqL9IKHD+HqmuS/YZOf9gaeMVOtoT8uSFrwMq+Ya4ivQXIaJzBHFqiKCv2CrHxOg==
X-Received: by 2002:a17:90b:1e47:b0:285:b78a:dbce with SMTP id pi7-20020a17090b1e4700b00285b78adbcemr18494984pjb.37.1701388078043;
        Thu, 30 Nov 2023 15:47:58 -0800 (PST)
Received: from [10.69.71.77] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ft8-20020a17090b0f8800b00283a0b0fd39sm1902721pjb.53.2023.11.30.15.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 15:47:56 -0800 (PST)
Message-ID: <d870c149-4363-43de-b0ea-7125dec5608e@broadcom.com>
Date: Thu, 30 Nov 2023 15:47:55 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Justin Chen <justin.chen@broadcom.com>
Subject: ARM Ftrace Function Graph Fails With UNWINDER_FRAME_POINTER
To: rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
 linux@armlinux.org.uk, linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, ardb@kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Doug Berger <doug.berger@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000adad0060b6748bc"

--0000000000000adad0060b6748bc
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Ran into an odd bug that I am unsure what the solution is. Tested a few 
kernels versions and they all fail the same.

FUNCTION_GRAPH_FP_TEST was enabled with 953f534a7ed6 ("ARM: ftrace: 
enable HAVE_FUNCTION_GRAPH_FP_TEST"). This test fails when 
UNWINDER_FRAME_POINTER is enabled. Enable function_graph tracer and you 
should see a failure similar to below.

[   63.817239] ------------[ cut here ]------------
[   63.822006] WARNING: CPU: 3 PID: 1185 at kernel/trace/fgraph.c:195 
ftrace_return_to_handler+0x228/0x374
[   63.831645] Bad frame pointer: expected d1e0df40, received d1e0df48
[   63.831645]   from func packet_setsockopt return to c0b558f4
[   63.843801] Modules linked in: bdc udc_core
[   63.848246] CPU: 3 PID: 1185 Comm: udhcpc Not tainted 
6.1.53-0.1pre-gf0bc552d12f8 #33
[   63.856209] Hardware name: Broadcom STB (Flattened Device Tree)
[   63.862227] Backtrace:
[   63.864761]  dump_backtrace from show_stack+0x20/0x24
[   63.869982]  r7:c031cd8c r6:00000009 r5:00000013 r4:c11c7fac
[   63.875736]  show_stack from dump_stack_lvl+0x48/0x54
[   63.880929]  dump_stack_lvl from dump_stack+0x18/0x1c
[   63.886111]  r5:000000c3 r4:c11bd92c
[   63.889764]  dump_stack from __warn+0x88/0x130
[   63.894339]  __warn from warn_slowpath_fmt+0x140/0x198
[   63.899631]  r8:d1e0deac r7:c11bd958 r6:c031cd8c r5:c11bd92c r4:00000000
[   63.906431]  warn_slowpath_fmt from ftrace_return_to_handler+0x228/0x374
[   63.913294]  r8:c3a8d840 r7:00000002 r6:d1e0df48 r5:c2377a94 r4:c269a400
[   63.920095]  ftrace_return_to_handler from return_to_handler+0xc/0x18
[   63.926699]  r8:c0cd8ed0 r7:00000008 r6:c418c500 r5:00000004 r4:00000107
[   63.933500]  __sys_setsockopt from return_to_handler+0x0/0x18
[   63.939415]  r8:c02002bc r7:00000126 r6:00000003 r5:00000000 r4:00000004
[   63.946217]  sys_setsockopt from return_to_handler+0x0/0x18
[   63.952053] ---[ end trace 0000000000000000 ]---

Sure enough the top of the parent stack is off by 8. (Tested with 
gcc6.3/gcc8.3/gcc12.3)
00006dcc <packet_setsockopt>:
     6dcc:       e1a0c00d        mov     ip, sp
     6dd0:       e24dd008        sub     sp, sp, #8 <======
     6dd4:       e92ddff0        push    {r4, r5, r6, r7, r8, r9, sl, 
fp, ip, lr, pc}
     6dd8:       e24cb00c        sub     fp, ip, #12
     6ddc:       e24dd06c        sub     sp, sp, #108    @ 0x6c
     6de0:       e52de004        push    {lr}            @ (str lr, [sp, 
#-4]!)
     6de4:       ebfffffe        bl      0 <__gnu_mcount_nc>

I'm not quite sure why gcc is putting this extra 8 byte frame (maybe 
some optimization?), but it isn't being accounted for thus the 
FUNCTION_GRAPH_FP_TEST for arm fails. Note that only some functions do 
this. Function graph works with FUNCTION_GRAPH_FP_TEST disabled, so it 
looks the test is hitting false positives.

Thanks,
Justin

--0000000000000adad0060b6748bc
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
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJloi0Vk8q0goTGBucHktZIU9XANRdsAAhBq
qOhdwt+AMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEzMDIz
NDc1OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQAO044PBPVvdALgZ5tB1HzCKALWJjZM36UvY3Adcs8CW9FiVVYFJfyP
etlF2dZMsDimQDyPpPikZKOI5XyvR2ONU1v7OZWZqSVI7rAgPOnD9RoVunYCnY9SABpJVgRLSxJw
WCi35xv15ffEfFMQigvazhKyuE6P/5YpuGw4QxKSv9FJHdHea5mKsqooJyBCyMPaa9KA3/hqRGGT
OLzp7b+nkY8fU2kLxtU1kv/hY5mO8/rXWfzAfx+JG9l+ml6srqHyQhLyl1jj2UJXkBIxrv8pciB8
I2IuQH/IwAmHGQcyT3veVoiAG4iwvK2k6/b1Xziow9as8bD8IxIsx9Wwh/I+
--0000000000000adad0060b6748bc--
