Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924D23B8D7B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590100; cv=none; b=g/8o1X0oaqo6RKAVZuZUErr3OIRBFqJwRtm1Fnx6yIBpr+kk6eKxfH9Z7F3dy4h0vqCE257nfiRpvIB8a/PHrS1TJjNQeyJxQQVhmIo91qhkRfFDypA+6BEdi5/WmgXCu025whRjaVtmXDWd3aVzJVOL9idhfn/XpclMfAKfVds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590100; c=relaxed/simple;
	bh=A8E1Y2hazzhMydNg7fCozaZVk5b5D4VsJ4Fn2WDnqjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zq7hCnkq1fSIkWEcY0FbysMuI6wwTWKnn1laOeIs+bNBSpgxKWLsuEKuELc9iLnml13hnAMqVYAzoMj82jpJT9sOWNzBhSV2r8397xcGa4TwJa5pEo3NiDq6e5tHu6MGaZeh9ODqVplS9IvRGKg/+mCxdailx4fV5nm29n5U8z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sZBx668K; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZBx668K"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469f204f6so1315986b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 03:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790590099; x=1791194899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=94R3HOVsdmaA8MXmlEUyCL2sani8cX70snLYFb2YBwk=;
        b=sZBx668K7E3atGOevWjKnUB9h6P55oATxfjUtSygQB1mpyjGXPfW5fbcLuJrLL/s5F
         8sbellFQlI4X93qnAmCedWuYLTbk4c3guaj8z1DcAegq86HHRFkwjoBaFcHcVca5Cssl
         liPl42L/fxqNh2Fn0aQNQHyM9cfiaJ9xJsyKZTRoFlFlSt3Sx42xHX0aBxgTTHZiLyfT
         vk6fOIxIauR4BKAV2cXa7Wt5K0GEYU54vGyLoBTg99mTCSDgWeIz0cKm1VsPruA5xVy9
         +lSpHN2M+7r6bpdvPffFGqG31mNqSEA34S988RYmblHurcNuotcFWrtPy66xIR6IMYur
         +KHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790590099; x=1791194899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=94R3HOVsdmaA8MXmlEUyCL2sani8cX70snLYFb2YBwk=;
        b=PwaFnhaw0X2LcISbb90vp6WDXbF7sT+w7blZFE4dwSMSvAq93TWOTaWNau7zpydTQR
         jatDLmooSoX12juAXoB9lXrDzLpBArxFtGJSXdIye8kJNCzEsEUirckkV2HWSKxPc7hD
         IWMhmAGQeoqVcshX67wFXQWxW23+oi1+RtJcHVxYN18eusYUtPqmZ1KbhmTDdviF9B3/
         6bxj/WU/iEDC/2028XBssxeLw1Q5wlIVV78EN71viRym1t3ogd5pytk+qDplqFLc8NFY
         fR2dn4Iwaj5HAAddQr05jAA3yCDetzvmXrQjcck46xT02Vfa2webVuL+WRylQ0rjSUd4
         u32w==
X-Forwarded-Encrypted: i=1; AKwUvBz88V4BHU17te6WTcamOca4+q9zzlnpsIUFGOSoQiz5a0fwleTgs4KryeXPN3yEm6+FuJ/yAV4eHZSYUNNHI7jLXbA=@vger.kernel.org
X-Gm-Message-State: AFuF++lzcEPBRlfw8pZRFJv48eQ2tWl31aq3as4AWcFE35rNV5PjopZj
	s824VRfWRf8bVpCtg7atnrBC4oScj6y1Ir8xa+BmIjp1JAyhkDQMgeRR
X-Gm-Gg: AYBFou2W0g7brRNCyRMvAXnq3JiLlH9+9q5oXyLyCmuLaUH4KlVQ1RNKBFcKnHIb/nJ
	7gBFtBR3QnSHgKiQyaLwbDfHdNikHP5fDzHdH4+5dDM8bbAIQnrX0VtwFvB8fPmuD5XLF+ClPEr
	z+q6/Lb3QJ+1+StjiIHE3ySbc+l37YLmBWp+ZIX7NLjtOVEGg5FTnaY/gGGqHGFO0zQgy9zPOnr
	a/9GduRcq4g4NEgC1EUShzkZP7SB7LBiFuHe/lZvCsl2WB+A8speiGKaXyvu2P4sBZhFX4YyaeY
	RUlDmQJWEf9AQLVBaUP0SIedsqd+WVWzMRrhA84ikMppPU9Uo4xBpRwZGHrtTFznkbcDs6rsyg+
	7kobmBL0Qa5BZqau2NPd351S3ASXyNf35gr5gAnCLMqvD0OWpQmTKZArjPvDkiVy96s9I+x3eMl
	XIcJj96H459hfOfcw8E2gc07Nyr+wOhT8c8YPJTFtctcLLe1z1huICelrxLREuU9RoSur/TkcYL
	t5j8yGaNU5QrkO/byNOPqrVM7cFu9Net5JpXnoAgcxcX1tY0oM=
X-Received: by 2002:a05:6a00:4148:b0:878:34b8:2322 with SMTP id d2e1a72fcca58-87e9bd7b48fmr8166354b3a.42.1790590098825;
        Mon, 28 Sep 2026 03:08:18 -0700 (PDT)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:3bf4:e1ea:ed85:cbcd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87feb97e845sm3904226b3a.54.2026.09.28.03.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 03:08:18 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	peterz@infradead.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v17 00/13] tracing: wprobe: x86: Add wprobe for watchpoint
Date: Mon, 28 Sep 2026 18:07:44 +0800
Message-Id: <20260928100744.2073454-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <179005108298.388919.4535333252892590932.stgit@devnote2>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We have made a preliminary ARM64 port of the v17 wprobe series and=0D
validated the basic paths on a real Android ARM64 device.=0D
=0D
The device is:=0D
=0D
  Kernel: 6.12.69-android16-6-4k=0D
  Architecture: arm64=0D
=0D
The relevant configuration includes:=0D
=0D
  CONFIG_HAVE_POST_BREAKPOINT_HOOK=3Dy=0D
  CONFIG_HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR=3Dy=0D
  CONFIG_WPROBE_EVENTS=3Dy=0D
  CONFIG_WPROBE_TRIGGERS=3Dy=0D
=0D
The following paths passed on the real device:=0D
=0D
  - fixed-address read watchpoint;=0D
  - fixed-address write watchpoint;=0D
  - tracepoint -> set_wprobe;=0D
  - dynamic ARM64 watchpoint address update;=0D
  - tracepoint -> clear_wprobe;=0D
  - no further wprobe records after clear_wprobe.=0D
=0D
For the dynamic test, we used the ptr field from the kmem:kmalloc=0D
tracepoint:=0D
=0D
  set_wprobe:dyn_watch_log:ptr:count=3D1=0D
=0D
The trigger changed the ARM64 hardware watchpoint address to the=0D
dynamically obtained pointer and generated 6 wprobe access records. We=0D
then used a sched_process_exit trigger to execute:=0D
=0D
  clear_wprobe:dyn_watch_log:count=3D1=0D
=0D
The wprobe state changed from 1* to 0*. The hit count remained 6 after=0D
the clear operation, confirming that no additional wprobe records were=0D
generated after clearing. No BUG, Oops, panic, or wprobe-related warning=0D
was observed during this test.=0D
=0D
We also exercised the basic ARM64 watchpoint hit and post-watchpoint=0D
single-step path on QEMU. The real-device result is the more important=0D
validation.=0D
=0D
There are two limitations worth mentioning:=0D
=0D
  1. The current Android device does not enable CONFIG_FPROBE_EVENTS, so=0D
     the fprobe -> set_wprobe path has not been tested on this device.=0D
=0D
  2. kprobe -> set_wprobe is currently rejected by design. The device=0D
     reports:=0D
=0D
       Wprobe trigger is not supported on kprobe event=0D
=0D
     We understand and respect this restriction, and we are not proposing=0D
     to remove it in this series.=0D
=0D
Our use case for a possible future extension is more specific than=0D
monitoring every kmalloc return value. A selected kernel function may call=
=0D
kmalloc() internally, store the returned pointer in a register, stack slot,=
=0D
local variable, or structure field, and then access fields of the newly=0D
allocated object. We would like to monitor the object produced by that=0D
particular allocation call site, rather than re-arm wprobe for every=0D
kmalloc in the system.=0D
=0D
One possible design would be a restricted, call-site-specific=0D
kprobe-to-wprobe interface:=0D
=0D
  - a kprobe is placed at a selected instruction offset in the caller;=0D
  - a user-space frontend resolves the pointer source from the matching=0D
    vmlinux, BTF/DWARF, and disassembly;=0D
  - the frontend supplies an explicit register/stack/field fetch;=0D
  - the kernel arms a wprobe on the resolved object or one of its fields.=0D
=0D
In this model, the user-space frontend would handle symbol resolution,=0D
disassembly, call-site selection, pointer-source analysis, structure-field=
=0D
resolution, and tracefs setup. The kernel would not need to parse arbitrary=
=0D
compiler local variables. It would only need to provide a restricted and=0D
safe mechanism for consuming an already-resolved pointer and updating the=0D
hardware watchpoint.=0D
=0D
We are not suggesting that an arbitrary kprobe handler should directly=0D
perform unrestricted set_wprobe operations. We understand that kprobes,=0D
ARM64 debug exceptions, single-step handling, tracing recursion, and=0D
cross-CPU watchpoint updates require a separate safety design.=0D
=0D
As an additional limitation, a high-frequency test that repeatedly=0D
re-armed the watchpoint from kmem:kmalloc showed a non-zero missed count.=0D
The controlled one-shot set/clear test passed, but the high-frequency case=
=0D
needs further investigation.=0D
=0D
The complete real-device log and test script are available if useful.=0D
=0D
Best regards,=0D
=0D
Pengfei=0D
