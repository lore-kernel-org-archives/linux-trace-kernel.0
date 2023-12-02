Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fY78+G/Q"
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D17DEB
	for <linux-trace-kernel@vger.kernel.org>; Sat,  2 Dec 2023 00:49:10 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5c210e34088so1087770a12.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 02 Dec 2023 00:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701506950; x=1702111750; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j2POFHPTVZ8Rw+wl8ce66+GsuX6umXTgoxAXwtYTTu8=;
        b=fY78+G/QKD3gopgvU7rzAPYCj6j9AbZN4uiM/Bz0s7dRnQyCf3JfLr+mxP+atAwSVl
         wNXDn31RmuWmMyJAv/HQacIovLEjGDHLbTjhRJvc/mqevn7v4TwX+iPkDrkqn9o0gbZ+
         ReBKmvsm1Z59z14nZhjBQCu1P+qEx80lVRB2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701506950; x=1702111750;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2POFHPTVZ8Rw+wl8ce66+GsuX6umXTgoxAXwtYTTu8=;
        b=dRZw/J6VLw/prEa7Y3NtdNTZz6VuWqK+636s5ig7+fQWCrq+Z8CqWV7lO2rfFRJD/q
         uPJKwhpCwCiL3a51R4GqhOftxPiZx42qPJ8xwSX6OWOPzU59If5pwh8Dk4eqoRdZRomt
         eJvU3+PR6ap1ZzqMM3NqIZ9xw7fCgTmQVSs2S4L3fq3Lk8VyX50HdyZCEOzuy4Nr50Np
         Mi3Y3xDbyn+BUWeCXRBT3ATEQa8kNTXiyf9F3IH2fVdkOzs7wL1Jp1IID3fO6KGrXUq8
         kIEU2+qd8QHD86nA4nlnDXtCNdpIGMyItSUD1fMHHb7odGM0NJsSTH1pLkHfj8OiPToD
         qXew==
X-Gm-Message-State: AOJu0YwNcAbUKQFZJq1fXfusELcKFsKWuvLzKhFRx99gIh1Iz0LAFtF4
	r6YjnS2kq5Wg+56/v/0JaW5Csw==
X-Google-Smtp-Source: AGHT+IHDrvx2nNhodGW4jR7Iw3L1iSqKjrogLhL7j9Ui0xZ5uDCTp2PR33u/N+zu5Y2bQf2KcWdmRg==
X-Received: by 2002:a17:902:e812:b0:1cf:9e88:100d with SMTP id u18-20020a170902e81200b001cf9e88100dmr1100078plg.59.1701506949884;
        Sat, 02 Dec 2023 00:49:09 -0800 (PST)
Received: from [192.168.86.43] ([136.52.74.64])
        by smtp.gmail.com with ESMTPSA id fs4-20020a17090af28400b00280786d9194sm6392558pjb.7.2023.12.02.00.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Dec 2023 00:49:08 -0800 (PST)
Message-ID: <dc1dd584-1970-4460-b76c-3cd9300a23e4@broadcom.com>
Date: Sat, 2 Dec 2023 00:49:07 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ARM Ftrace Function Graph Fails With UNWINDER_FRAME_POINTER
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
 mark.rutland@arm.com, linux@armlinux.org.uk,
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Doug Berger <doug.berger@broadcom.com>
References: <d870c149-4363-43de-b0ea-7125dec5608e@broadcom.com>
 <CAMj1kXGST7uH530hB0i-rzisNesNrUGsJ5a5eC9805Udi5msrQ@mail.gmail.com>
 <81af85b4-5274-4362-9413-890425c60524@broadcom.com>
 <20231201130702.2824115c@gandalf.local.home>
 <4597db06-dabc-4bb2-9f24-bd30e07ff86d@broadcom.com>
 <CAMj1kXFMy0=DP3-Ycsj+XCHWxvqNqddBkEm71Nrr-m9gVca21w@mail.gmail.com>
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <CAMj1kXFMy0=DP3-Ycsj+XCHWxvqNqddBkEm71Nrr-m9gVca21w@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005b1753060b82f5e5"

--0000000000005b1753060b82f5e5
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/1/23 10:53 PM, Ard Biesheuvel wrote:
> On Fri, 1 Dec 2023 at 23:59, Justin Chen <justin.chen@broadcom.com> wrote:
>>
>>
>>
>> On 12/1/23 10:07 AM, Steven Rostedt wrote:
>>> On Fri, 1 Dec 2023 09:25:59 -0800
>>> Justin Chen <justin.chen@broadcom.com> wrote:
>>>
>>>>> It appears the sub instruction at 0x6dd0 correctly accounts for the
>>>>> extra 8 bytes, so the frame pointer is valid. So it is our assumption
>>>>> that there are no gaps between the stack frames is invalid.
>>>>
>>>> Thanks for the assistance. The gap between the stack frame depends on
>>>> the function. Most do not have a gap. Some have 8 (as shown above), some
>>>> have 12. A single assumption here is not going to work. I'm having a
>>>> hard time finding out the reasoning for this gap. I tried disabling a
>>>> bunch of gcc flags as well as -O2 and the gap still exists.
>>>
>>> That code was originally added because of some strange things that gcc did
>>> with mcount (for example, it made a copy of the stack frame that it passed
>>> to mcount, where the function graph tracer replaced the copy of the return
>>> stack making the shadow stack go out of sync and crash). This was very hard
>>> to debug and I added this code to detect it if it happened again.
>>>
>>> Well it's been over a decade since that happened (2009).
>>>
>>>     71e308a239c09 ("function-graph: add stack frame test")
>>>
>>> I'm happy assuming that the compiler folks are aware of our tricks with
>>> hijacking return calls and I don't expect it to happen again. We can just
>>> rip out those checks. That is, if it's only causing false positives, I
>>> don't think it's worth keeping around.
>>>
>>> Has it detected any real issues on the Arm platforms?
>>>
>>> -- Steve
>>
>> I am not familiar enough to make a call. But from my limited testing
>> with ARM, I didn't see any issues. If you would like me to, I can submit
>> a patch to remove the check entirely. Or maybe only disable it for ARM?
>>
> 
> Please try the fix I proposed first.

Just tested it. Seems to do the trick. Either solution works for me.

FWIW I also experimented with LLVM, looks like function_graph just 
crashes regardless of the issue being discussed. The disassemble of 
LLVM[1] does something completely different.

Thanks,
Justin

[1]
LLVM dump
c0c6faa0 <sk_getsockopt>:
c0c6faa0: f0 4f 2d e9   push    {r4, r5, r6, r7, r8, r9, r10, r11, lr}
c0c6faa4: 1c b0 8d e2   add     r11, sp, #28
c0c6faa8: ac d0 4d e2   sub     sp, sp, #172
c0c6faac: 00 70 a0 e1   mov     r7, r0
c0c6fab0: c8 0c 04 e3   movw    r0, #19656
c0c6fab4: 80 02 4c e3   movt    r0, #49792
c0c6fab8: 03 50 a0 e1   mov     r5, r3
c0c6fabc: 00 00 90 e5   ldr     r0, [r0]
c0c6fac0: 02 a0 a0 e1   mov     r10, r2
c0c6fac4: 20 00 0b e5   str     r0, [r11, #-32]
c0c6fac8: 00 40 2d e9   stmdb   sp!, {lr}
c0c6facc: 4b 8b d6 eb   bl      0xc0212800 <__gnu_mcount_nc> @ imm = 
#-10867412

--0000000000005b1753060b82f5e5
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
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEKHJh79fJpJwpst58ndzykBDym3DWm2wlHu
vqYHyREqMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIwMjA4
NDkxMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQB/+Gfb7Zrb7h5nWlo+aHvTVuP7JMw3nbjhDzRR5tiF554IpwWEFxN+
BEq28Y++8iAf6JE7AsiTkvbEmpZoxYugSUiBZf2eDJV+E8kU4v5QpHvxCSe30JA84ykXWRT5AsXb
LLbLPA2Nz4zJjEyzZFW/y71w7Rv6s2EVw2tXfdvTQ7alpN6XwiNarRG//wzJAU8ocpBQsZDPXrNh
VeFIHD77ths7tIG80vFaTHBFoMeZfQ5K4guzISi1SQDdNSYwp7k4O6TA6m5pSbNL/41n9IFv6Tdl
ozMX+qHpA4J8G2BLVP7+Yzb/8xQHs66ZYjovsYi8AKa+WmaW2GmKL154FNsI
--0000000000005b1753060b82f5e5--
