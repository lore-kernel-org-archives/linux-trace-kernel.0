Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AE932E143
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103855; cv=none; b=drS55tBjMgWF3zun6bY6e8hHoxMTMIFKDCT++cTQqSwe4QhA4j0sX7UNOwMn3ehBZ20x3ZkdqPCPzHKmLB5R5TjKzDLDHRdwMkxOiNtXdDxYvsIeYG2syTQA4NATPQSUPyP/0NTwcJQnDV8f57d1mat/7tuJE/kSElktuoSMeYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103855; c=relaxed/simple;
	bh=enBcm4wrrpDoNve2OoglA/oNbmzssukVPw4pJaBDD08=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ErWrpeg0wygjcvxjPGJx7PqGuYTtJ0oKZXet2aFNAroAC0mE7OA/+6No3rw9ZiQEIBTf/YKI03h/j61bck/GDcpF43YPUw2Y8p7+E41LC0ZL2NYeTlPvJazHL5VUUbLkdav7AgqzQo980UHHLGyaYuZUqnIFOJJukxJByaKJDU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FFcQoiFe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFcQoiFe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781103853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=enBcm4wrrpDoNve2OoglA/oNbmzssukVPw4pJaBDD08=;
	b=FFcQoiFeB9XB0+d/7+ZrLWmu4/NAPTuAbVvPS03wGCePfsd0SOLkhb8jOhxim3Bpu+b3bm
	o7R9ACf9+gFNi5Ka4McrpBngy6bmthSwPEOT2xgPyGdEVTij6SlreXpRaV3Qa7dKwnOeQK
	aELRQl6mIWthoOSfVMIfrxKvVlY6jGU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-ghRH_erUOgiJEvXZu3deag-1; Wed, 10 Jun 2026 11:04:11 -0400
X-MC-Unique: ghRH_erUOgiJEvXZu3deag-1
X-Mimecast-MFC-AGG-ID: ghRH_erUOgiJEvXZu3deag_1781103850
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-bec44ccbbd0so505880766b.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 08:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781103850; x=1781708650;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zEGei+1octJ/5faqtzj3TixGq6wfkFVyGs4Gckx9pgo=;
        b=LWaMsEyccwVwJDdjuIkIx74ffAtH6at5FWq4SqhCz02bdF7ow/uORETHpHBebl7KyB
         P0BhCG3+HhbcYOC5MqGtfnEDoJtp0kycwVtERQjFlIi0gwwXcnLH1pKFLMcbWP2oPDPg
         F8y69Gm4m9wn+EuJXVruc32aqogEqNyXx0sk+2u/thlvoFt7gij7zTwK2CXtCkM7kSho
         Z4DyExH/nGzgHLYSAxu7qo/vDoSykDO5JBhj+YoYDEZo/6n9hOLyAWjMYnwjEDXW96QW
         1L93dn6mwimPcGCJOjHFjF2bfe/MpWE9w6EPZrJjrD/X8IYuBdpmgtzIidm9UDnSSR/T
         cLvQ==
X-Forwarded-Encrypted: i=1; AFNElJ9W/cg5qNgi7Yl1eSDTUB5Q5pX3lIkn/TN4HI6usJ5o2D+O10V8oA+nWw2OsxCLzCsqC/BPhDwOaBArNFW2z8AQbuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx31BK/JYOGfr53+soPQOENaZygdeU+vZo8HuM53d+whRRr3QGn
	ucgDaP/L+vahK67m0Yg1cw6RpqKgX3y7JZkaEtDkzO+bYT9lqjwvtxD8McB/lI3PC9TG7HAn4Zd
	C+QYCc6lZ2COrKqd2sxfOTnSUW3nkDnYdUTySgVA4f5bZJ128vw7vcZdgJkiPo30Y2JmvgTOiTa
	oWCHlXJw==
X-Gm-Gg: Acq92OGXyE5KFCg8CamISA8yGSeoWbB0uiKXRNctQids4NVy7q0U9pN6GGm6/jPkOKH
	5RJoprUzl4jyM1OtLcr2IOjKwyZTxyFsnOXd3WpwmBb1ERzjpweTe8wx3W/1/y/UtmPz68iPXP8
	x0bXVEn1rhGX55t32+yKZj4D9CBZovGjD+bkrJ3qoOdfdc4OrOykd0qcT6fStWTHVGE8fBmpo78
	qK3MwW4KorTuXFfX8dnIC1JSGV6kZL962jO6bzMaL651fMhA474WJ2goXIKc7R0ifVtB41KwxBK
	IR2UWs8qpu+c21cIUXlu6wsFLNlbshNc57oT0UwJ7mmUtxWBg/Mq/50aO3y/tcMK4gLhfgYZbtA
	pz6bzqst8sx1Y54XhPggTX9sdkZXoHn0cM5dj
X-Received: by 2002:a17:907:3d16:b0:bd4:8b66:c374 with SMTP id a640c23a62f3a-bf36ff8e279mr1278855766b.9.1781103850240;
        Wed, 10 Jun 2026 08:04:10 -0700 (PDT)
X-Received: by 2002:a17:907:3d16:b0:bd4:8b66:c374 with SMTP id a640c23a62f3a-bf36ff8e279mr1278851666b.9.1781103849638;
        Wed, 10 Jun 2026 08:04:09 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4b18sm56936769f8f.10.2026.06.10.08.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:04:09 -0700 (PDT)
Message-ID: <e3f63618b48dba9299c88bfffeae14b71717fa77.camel@redhat.com>
Subject: Re: [PATCH v3 09/13] verification/rvgen: Delete __parse_constraint()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa
	 <wander@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 10 Jun 2026 17:04:08 +0200
In-Reply-To: <8d9b9068a5dde8256edd7debe7aab33e15a7fc51.1780908661.git.namcao@linutronix.de>
References: <cover.1780908661.git.namcao@linutronix.de>
	 <8d9b9068a5dde8256edd7debe7aab33e15a7fc51.1780908661.git.namcao@linutronix.de>
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0TkrELg7V62tcH2TwJfEvOH00Yin6HYXGEkiN-bZ26Q_1781103850
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gTW9uLCAyMDI2LTA2LTA4IGF0IDEwOjU3ICswMjAwLCBOYW0gQ2FvIHdyb3RlOgo+IC3CoMKg
wqAgZGVmIF9fdmFsaWRhdGVfY29uc3RyYWludChzZWxmLCBrZXk6IHR1cGxlW2ludCwgaW50XSB8
IGludCwKPiBjb25zdHI6IHN0ciwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBydWxlLCByZXNldCkgLT4gTm9uZToKPiAtwqDCoMKg
wqDCoMKgwqAgIyBldmVudCBjb25zdHJhaW5zIGFyZSB0dXBsZXMgYW5kIGFsbG93IGJvdGggcnVs
ZXMgYW5kIHJlc2V0Cj4gLcKgwqDCoMKgwqDCoMKgICMgc3RhdGUgY29uc3RyYWludHMgYXJlIG9u
bHkgdXNlZCBmb3IgZXhwaXJhdGlvbnMgKGUuZy4KPiBjbGs8TikKPiAtwqDCoMKgwqDCoMKgwqAg
aWYgc2VsZi5pc19ldmVudF9jb25zdHJhaW50KGtleSk6Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgbm90IHJ1bGUgYW5kIG5vdCByZXNldDoKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJhaXNlIEF1dG9tYXRhRXJyb3IoIlVucmVjb2duaXNlZCBldmVudCBjb25zdHJhaW50
ICIKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoAo+IGYiKHtzZWxmLnN0YXRlc1trZXlbMF1dfS97c2VsZi5ldmVu
dHNba2V5WzFdXX06IHtjb25zdHJ9KSIpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgcnVs
ZSBhbmQgKHJ1bGVbImVudiJdIGluIHNlbGYuZW52X3R5cGVzIGFuZAo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcnVsZVsiZW52Il0gbm90IGluIHNl
bGYuZW52X3N0b3JlZCk6Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYWlzZSBB
dXRvbWF0YUVycm9yKCJDbG9ja3MgaW4gaHlicmlkIGF1dG9tYXRhCj4gYWx3YXlzIHJlcXVpcmUg
YSBzdG9yYWdlIgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGYiICh7cnVsZVsiZW52Il19KSIpCj4gLcKgwqDC
oMKgwqDCoMKgIGVsc2U6Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgbm90IHJ1bGU6Cj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYWlzZSBBdXRvbWF0YUVycm9yKCJVbnJl
Y29nbmlzZWQgc3RhdGUgY29uc3RyYWludCAiCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZiIoe3NlbGYuc3Rh
dGVzW2tleV19Ogo+IHtjb25zdHJ9KSIpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgcnVs
ZVsiZW52Il0gbm90IGluIHNlbGYuZW52X3N0b3JlZDoKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJhaXNlIEF1dG9tYXRhRXJyb3IoIlN0YXRlIGNvbnN0cmFpbnRzIGFsd2F5cwo+
IHJlcXVpcmUgYSBzdG9yYWdlICIKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmIih7cnVsZVsiZW52Il19KSIp
CgpUaGlzIGZ1bmN0aW9uIHVzZWQgdG8gdmFsaWRhdGUgdGhpbmdzIHdlIGFyZSBubyBsb25nZXIg
dmFsaWRhdGluZywgbm93IGl0J3MKYWxyaWdodCB0byBjcmVhdGUgYSBtb2RlbCB3aGVyZSBhIGNs
b2NrIGlzIG5ldmVyIHJlc2V0LCB3aGljaCBkb2Vzbid0IGZ1bGx5Cm1ha2Ugc2Vuc2UuIFNob3Vs
ZCB3ZSBhZGQgdGhhdCBjaGVjayBzb21ld2hlcmUgZWxzZT8KClRoYW5rcywKR2FicmllbGUKCj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgcnVsZVsib3AiXSBub3QgaW4gWyI8IiwgIjw9Il06
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYWlzZSBBdXRvbWF0YUVycm9yKCJT
dGF0ZSBjb25zdHJhaW50cyBtdXN0IGJlIGNsb2NrCj4gZXhwaXJhdGlvbnMgbGlrZSIKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBmIiBjbGs8TiAoe3J1bGUuc3RyaW5nfSkiKQo+IC0KDQo=

