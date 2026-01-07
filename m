Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC90A30F55D
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791018; cv=none; b=kims6H2U71zOUT6drlzubHxjGSHESNpwL3L2hIcMbicCti4S/ozXkuyGicT/iDjoaqGWuuWy8sb+Vp5VjD4193ozwwNPrX5YxHVOA92R4hRAhAHxrtdrI9AcOWgTOc/opWoZCYGgm7VFe1jX4DRY/srijSieP2fzKUF85xSo7io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791018; c=relaxed/simple;
	bh=s7GTh11L2i2KI3LvsWAFeFcx8JWTGou+tuO3WnXU218=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RzBMymSFyhcwYml3OR+CHmmgKqC6h3e9OBylBXc/0PBJ7QRRkGVBVugfXcLzn4AaSriJ8wPl5STZXUQtNLW0cSuHtj1efd4QKns62Ef2U/MtI5tLxoUCUEijjA/OY5OrqzuCClc+3X3BMNYlYfmyg0ge35wSB+vjoNT69GZYtRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fR+PBtZx; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR+PBtZx"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-11b992954d4so1508998c88.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Jan 2026 05:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767791016; x=1768395816; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7GTh11L2i2KI3LvsWAFeFcx8JWTGou+tuO3WnXU218=;
        b=fR+PBtZxEY+N0Njaja/uKAKcp5uQMBZcHwjdMwGFFFrkviInaQ6jX6hZSFgvoqEw3o
         fEQU3b6aDbISNzAIfXKmPuUXuUhgU8LHhVp0uBucCxUSsWC87Fng6bj/y0/LCsVscJ0P
         s0SAvUH0BR9KDX9/wEgpgtuS0JRexJFF5ejooEfkz4RwoXA9rEL0ET4Z4goCU1S4lCu2
         56FVZ0/3YAW+B5ak8XjSAk2TRhKGmopesDakWfY3WxKDLcFy6w4hSU6Z+pPR/4icehJR
         RjFOIPAyoNa9UIiZVMmQd94OsvCbI2pTJ6Y8XsPmAHTOlE31U0oqw29G9H8Z4xiS95yL
         iYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767791016; x=1768395816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s7GTh11L2i2KI3LvsWAFeFcx8JWTGou+tuO3WnXU218=;
        b=UTjWSLdie18rW4LGcroq1tpHTcRZS6SUBN/Qej9Z6JlSsJO6kG6k+/3uwsOyo1AJdR
         z+TclKOwttxoB5SAp4FkFHWLVwWweYiPlEMd6TCyHXSsUgeiOvO8y5NVJM0exkX7fO3k
         r9Wf3KWIHc39xWQIYvaLW2egaR3pKJdk2CLzJ3YzzkZG93FtkJDcYNvV96OjfMMgUuwA
         wZegAdXFnfKnr5RHnbzwvXmoV8qXJNCYu4GvghNV3g5PHLNDh5OnMESTF4GBUb5Vq3wm
         vDywJwfcBMXB3D8XE2m6o5qVWQxy+TNgnar7FNS74AMLkFBIFozsC4oScqygCjPhHsBU
         X1Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXZlxaNAE0r/0DmmiSJMIwKVFimShA3qW2T0ANrXfhsAHBoAaZ7cR/689bOrGN2OooZbZqtTy+BDHKVXPQL2DH1rvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWVPg+Ch01Z4cW6Wr5vlZnkjeUhyfp9pGi0Ogr7FJdG6mReUdw
	qDikrjETPo/irklfo9rpU2xnfuvvuNrZM44fVmXiy1j9NbPUvGxpy8BQ
X-Gm-Gg: AY/fxX5H0Slnr62+2JIdt4lJQmmaSMhGFeHyPsGLo2bFJfi+iIAzGsw/qcihYDEtMGN
	qKdGzuB0qr3vJ7JeeT+AXsd7Xbnqgf0EjZGGitdmw7v7nlMHrYrqJKUsl/eqKifULEaGmnUIqAZ
	Lv3laKc2OnLSQPh5sTBn36vR1YNdzb+yDICcZgbFQ+lZD0E44f9q1+nnFipTx1z1g8ldzAfu6UR
	WuWNqin56T425nkIOb4azGUs3FAROeQzl3BsN33OWczQuEs6zJ4qmtpNXpRM2GB2smbHe4TQXo/
	KS4FB+Gi0WAy0SDdvjCHeqQjs8zK8FUraedXvhQ4GoqLk8UfziZaOGw2+V0PCydab9xgmPTEwA2
	B7S/qeZgLfCa/io9K6YvTBpYzgh/Ae77RR8yJHbxfoZPj1E6Hm6NRhRZsXgncOG3SQGvSxcxfIY
	H2FN/iMB40sKilDx619gmmU7cU
X-Google-Smtp-Source: AGHT+IGnL2xjS0GT/VWvHOK4H+jFG4Caomv3SQN7QcEqr0Gwfdq8sN01qehGzYICVgdBY7YOseFREg==
X-Received: by 2002:a05:7022:eacd:b0:11b:79f1:847 with SMTP id a92af1059eb24-121f8b14836mr1854896c88.12.1767791015447;
        Wed, 07 Jan 2026 05:03:35 -0800 (PST)
Received: from smtpclient.apple ([38.207.158.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f24a65b9sm7985515c88.17.2026.01.07.05.03.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jan 2026 05:03:35 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH bpf 2/2] bpf: Require ARG_PTR_TO_MEM with memory flag
From: Zesen Liu <ftyghome@gmail.com>
In-Reply-To: <5be9eb70fb41e7278771d9ff1fe3493444a7c33d28f300f04fb8e3be73005ec4@mail.kernel.org>
Date: Wed, 7 Jan 2026 21:03:16 +0800
Cc: ast@kernel.org,
 daniel@iogearbox.net,
 andrii@kernel.org,
 martin.lau@linux.dev,
 eddyz87@gmail.com,
 song@kernel.org,
 yonghong.song@linux.dev,
 john.fastabend@gmail.com,
 kpsingh@kernel.org,
 sdf@fomichev.me,
 haoluo@google.com,
 jolsa@kernel.org,
 mattbobrowski@google.com,
 rostedt@goodmis.org,
 mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 horms@kernel.org,
 dxu@dxuuu.xyz,
 bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 electronlsr@gmail.com,
 gplhust955@gmail.com,
 haoran.ni.cs@gmail.com,
 martin.lau@kernel.org,
 clm@meta.com,
 ihor.solodrai@linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <9A68EC8A-3F7B-4CA0-B75B-195BE5E7495A@gmail.com>
References: <20260107-helper_proto-v1-2-e387e08271cc@gmail.com>
 <5be9eb70fb41e7278771d9ff1fe3493444a7c33d28f300f04fb8e3be73005ec4@mail.kernel.org>
To: bot+bpf-ci@kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.4)

You're right. I'll add the missing flags to these prototypes and address =
this in v2.


> On Jan 7, 2026, at 20:44, bot+bpf-ci@kernel.org wrote:
>=20
> Would these helpers fail check_func_proto() after this change, causing
> BPF programs using them to fail verification? Should these prototypes
> be updated to include MEM_RDONLY (since they read from the memory), or
> should the check skip ARG_PTR_TO_FIXED_SIZE_MEM?


