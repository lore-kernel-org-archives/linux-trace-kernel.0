Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JDma770m"
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF6090
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Dec 2023 14:59:49 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-42542163a1fso208791cf.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 01 Dec 2023 14:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701471588; x=1702076388; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B88Go7D82aLTZbdpIXijfJf2guDahmmgHLCKtmEtdYk=;
        b=JDma770ma4Xa/FiWktFbS79dPd3CNYznuhZLdKMa61F4PG9SAaRA4cAMTyBmvMyQX3
         8e7I1RSrV55ta7DxNTAV4W8vWYtrbDFhJKquKop7iPwdrD1Pix/rmNBqlkD2MVD+tg54
         Cqtto8VtKECuHI6yl2WoSjKQWCuA1uo/YUBq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701471588; x=1702076388;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B88Go7D82aLTZbdpIXijfJf2guDahmmgHLCKtmEtdYk=;
        b=l7fh7urlo/LJsuAf1pxHzmr2r7k/7b7ZvxOnSz+SlkWL4dAPsCh7Nw0ycb8zsHykim
         6X/2ZSmqFV2tpBhIN2fXwV3xQmyfD38eRr2VZPTBAIM6tQcscCcYrHSbjcgAmqTkbu7L
         YebMKitVw7/OniyTqsQ6GEUCYYFHRWE9aJZGiFP/vH7kS4MlRHkUEV08nxRjPjdKWlIT
         wgZXgM4jvN8+4fduKypx/1zLS5k9ZKHCXu4V6RPOrgqgJxdT51Zh0JfQjS0ptGAbn7dr
         gN/LEw8rH/lMXSH330zSEHQQie8EaCYNag7JRhV0KrIuLpR8EXoNMo9XzgaQduwvAr/5
         WNcA==
X-Gm-Message-State: AOJu0Yymc1bEPaFbFVKmdKDrDW0pVMZJDHSFhla/48qkcLIdx3WoNm4p
	saDdIyGTcep/a3OoUPFd8IyjBw==
X-Google-Smtp-Source: AGHT+IFNA3+xzLjts0ymi4U6IBpWggwtVLVReKbQ/zmhV+qJd0/tpgBYmXn1niUiXFAvOpFaSbelPw==
X-Received: by 2002:a05:622a:34c:b0:423:82dc:619a with SMTP id r12-20020a05622a034c00b0042382dc619amr342253qtw.20.1701471588633;
        Fri, 01 Dec 2023 14:59:48 -0800 (PST)
Received: from [10.69.71.77] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id hg15-20020a05622a610f00b00424059fe96esm1102079qtb.89.2023.12.01.14.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 14:59:47 -0800 (PST)
Message-ID: <4597db06-dabc-4bb2-9f24-bd30e07ff86d@broadcom.com>
Date: Fri, 1 Dec 2023 14:59:45 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ARM Ftrace Function Graph Fails With UNWINDER_FRAME_POINTER
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, mhiramat@kernel.org,
 mark.rutland@arm.com, linux@armlinux.org.uk,
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Doug Berger <doug.berger@broadcom.com>
References: <d870c149-4363-43de-b0ea-7125dec5608e@broadcom.com>
 <CAMj1kXGST7uH530hB0i-rzisNesNrUGsJ5a5eC9805Udi5msrQ@mail.gmail.com>
 <81af85b4-5274-4362-9413-890425c60524@broadcom.com>
 <20231201130702.2824115c@gandalf.local.home>
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20231201130702.2824115c@gandalf.local.home>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a735ef060b7ab908"

--000000000000a735ef060b7ab908
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/1/23 10:07 AM, Steven Rostedt wrote:
> On Fri, 1 Dec 2023 09:25:59 -0800
> Justin Chen <justin.chen@broadcom.com> wrote:
> 
>>> It appears the sub instruction at 0x6dd0 correctly accounts for the
>>> extra 8 bytes, so the frame pointer is valid. So it is our assumption
>>> that there are no gaps between the stack frames is invalid.
>>
>> Thanks for the assistance. The gap between the stack frame depends on
>> the function. Most do not have a gap. Some have 8 (as shown above), some
>> have 12. A single assumption here is not going to work. I'm having a
>> hard time finding out the reasoning for this gap. I tried disabling a
>> bunch of gcc flags as well as -O2 and the gap still exists.
> 
> That code was originally added because of some strange things that gcc did
> with mcount (for example, it made a copy of the stack frame that it passed
> to mcount, where the function graph tracer replaced the copy of the return
> stack making the shadow stack go out of sync and crash). This was very hard
> to debug and I added this code to detect it if it happened again.
> 
> Well it's been over a decade since that happened (2009).
> 
>    71e308a239c09 ("function-graph: add stack frame test")
> 
> I'm happy assuming that the compiler folks are aware of our tricks with
> hijacking return calls and I don't expect it to happen again. We can just
> rip out those checks. That is, if it's only causing false positives, I
> don't think it's worth keeping around.
> 
> Has it detected any real issues on the Arm platforms?
> 
> -- Steve

I am not familiar enough to make a call. But from my limited testing 
with ARM, I didn't see any issues. If you would like me to, I can submit 
a patch to remove the check entirely. Or maybe only disable it for ARM?

Thanks,
Justin

--000000000000a735ef060b7ab908
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQagYJKoZIhvcNAQcCoIIQWzCCEFcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3BMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBUkwggQxoAMCAQICDCPwEotc2kAt96Z1EDANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjM5NTBaFw0yNTA5MTAxMjM5NTBaMIGM
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFDASBgNVBAMTC0p1c3RpbiBDaGVuMScwJQYJKoZIhvcNAQkB
FhhqdXN0aW4uY2hlbkBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQDKX7oyRqaeT81UCy+OTzAUHJeHABD6GDVZu7IJxt8GWSGx+ebFexFz/gnRO/sgwnPzzrC2DwM1
kaDgYe+pI1lMzUZvAB5DfS1qXKNGoeeNv7FoNFlv3iD4bvOykX/K/voKtjS3QNs0EDnwkvETUWWu
yiXtMiGENBBJcbGirKuFTT3U/2iPoSL5OeMSEqKLdkNTT9O79KN+Rf7Zi4Duz0LUqqpz9hZl4zGc
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
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOQc05Y4mjP9Vp87n6+Lkp0hoFkHCITvo6Jd
rijbieLtMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIwMTIy
NTk0OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQCwHwooG/fiDahXPG4I5qthDsxUWoo0W94S6uLkajH8nWfPcID5afvj
rYsIKn4O6VVx98PnfwlVcD3QDlir+OQqJE8tGBzTxbbW6i9dwFekpbX3c5Ype9kf/T8GWPkwQ/K0
21ghr2Ky9Luyy3nFxaEsM7pQSo4MajFegm0SY7IRwCsS7CI+VOq3X5Dh9w4vMVKy6quVNcQIYmMO
gIsGUVq5e+YedEonoy6TkGBAs9Ru1PoS6YeKqGZd/yRkwSxVRsWr5p+PWrV/aiCPTpBQ/+P1eRsB
QF3EnuDQmZqoWSY4DNGc/2aHj4c0ZLXZ0Ymbk6Zlis6fWK1Vdhg2a4iLH1MQ
--000000000000a735ef060b7ab908--
