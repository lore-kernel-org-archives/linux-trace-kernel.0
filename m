Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B636227BAC
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Feb 2025 00:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738716984; cv=none; b=DjLOMukAnZ12BorMs7mVdoD65SwlUcVgp3d4I9QhyDilzyfh3vqmPC7eKj5zKMjib1K4Sn1//RaMW5o6P47EfQuZcw/quuIxBTII2EaSVwu+slf76w25z+xRajlly6KkuXPBQ4xvEdHw2xpo6jLQHmQtvoiMd7PvxrzEdycOkZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738716984; c=relaxed/simple;
	bh=9ij7khtd31hJX3bC+IFvIqGySEhuppZ7MucI5She8To=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=qUqw1NQ74J1xYGACgkpGhoQtC+22PI8fVexNgkMhUUPDthcB7mjpIh+cNHaTNf12QPixVanTAzAwZ1QXLhKcMP6R8TJw3iDl056bvzS6+e5QxWNOZ5zbHmxlBFZjwUQXVZ3XZey85dz6jkWL3yeD7HoGxBbAo1gzSkiRm661VG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=JTRXHJxb; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="JTRXHJxb"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e1a36b3684so72177626d6.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Feb 2025 16:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1738716982; x=1739321782; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ij7khtd31hJX3bC+IFvIqGySEhuppZ7MucI5She8To=;
        b=JTRXHJxb+8U+2PzYf10CesSBp7eGMv12OnUnanU9Qbx3qEb7uZH1u048Eebt5dvLKD
         Vm2NABsPInFBd6pRzkg2XQSbgQ9Ik7sNEzok2NwvQy9w0Dop8Ps3w7RMOIBQMO5wsl8+
         5TWQek43UlN8Ymclov5/can0twOXIo+HH3/1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738716982; x=1739321782;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ij7khtd31hJX3bC+IFvIqGySEhuppZ7MucI5She8To=;
        b=AKCckN0hjSRNA+HKU9exQWiTsNY/PbqLc0YAmAtIj45fwzIMPkC9+lxqDMUl9UErFE
         kWZL0yePvOepwJd1Od0Xyp1YTlfNfSjA50fXo3q8KwuLkEwB1W/E8egWpgK9PT9getZF
         gEyt3DlZe/cbUZE50TFXKY5pW3AbuK8OHXzES8VziZCNv8EFK23mNjxnEAgcIYtnCcSQ
         lDgovW6pcKs8PnnZ0p7FFYfwPGxeRvIK4xTw+zdGaaof0Fi4jyv/YaFmpxbHX1av2h6j
         f7yRGj/+czeuqh9Uy0OsUEfQWtHCvd7QQjEfy1pW1DvO9AvEM3+Aqo0XHv6626fTQ5AX
         M5mA==
X-Forwarded-Encrypted: i=1; AJvYcCUmcpaLvxUGgWX3kH7ZjYgcVqca+gmkBKxtbw3TRGXSCKihrb9V+842fsdQkq5GkGYFZJlJiaYzYPwbAKvCbofwHpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhP7o9P2o19yGOLUwLxUQ6aRH+7N/TSuPu6W/yKDNc322iP0Qd
	l1rr6OBaM+aWbVcGM3+WBbahVflptnLM0eUNjybmJhTX1ItmAx7S1+2YH6AW+9I=
X-Gm-Gg: ASbGncs8y61mfOIRBlruSqXxqkRkkTre+31Y/8vAH9JEChitWoik8nTFpPN58UhM2xL
	m5aczr/kMfcLkczU/enDvNGl4dpZh1lZf9TstBhQ0pjS8BlplaBDEeILPKUWVlGl1qq0m+emLnf
	1qwDEHtOXXYGwG362AlQkOPbk5W15BE+PRWsUQQBWbb9YPHblUmVy+X/hEQiNnJ1qlroX224jLX
	vU10wkkZPOXxv46mPgESMG52NpiLA7Jj/ZBB3DIgYnB9zkCSWGW7OcHFSHsroatbMnsW0MUgODp
	RTlGLwwJZQBRqTXQDO7KF8N56w1uGlm5PWN1slGyWNPUknRFxUiu+rLFioF2qT2S5kTWoX2gDLq
	V
X-Google-Smtp-Source: AGHT+IGIVVkrbX1KATNv8V2bEUqrsG5sfK5Qzl85BavL2KosHxDWEEmIEh2A+Ur9QNUp3/3BcOXuKA==
X-Received: by 2002:a05:6214:d42:b0:6e2:4d70:1fbd with SMTP id 6a1803df08f44-6e42fb99504mr16023586d6.6.1738716981866;
        Tue, 04 Feb 2025 16:56:21 -0800 (PST)
Received: from smtpclient.apple (c-73-251-172-144.hsd1.va.comcast.net. [73.251.172.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2547f2bbesm67911656d6.12.2025.02.04.16.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 16:56:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Date: Tue, 4 Feb 2025 19:56:09 -0500
Message-Id: <9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
References: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ankur Arora <ankur.a.arora@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, luto@kernel.org,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Konrad Wilk <konrad.wilk@oracle.com>, jgross@suse.com,
 Andrew.Cooper3@citrix.com, Vineeth Pillai <vineethrp@google.com>,
 Suleiman Souhlal <suleiman@google.com>, Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Clark Williams <clark.williams@gmail.com>, bigeasy@linutronix.de,
 daniel.wagner@suse.com, Joseph Salisbury <joseph.salisbury@oracle.com>,
 broonie@gmail.com
In-Reply-To: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
To: Prakash Sangappa <prakash.sangappa@oracle.com>
X-Mailer: iPhone Mail (22B91)



> On Feb 4, 2025, at 5:44=E2=80=AFPM, Prakash Sangappa <prakash.sangappa@ora=
cle.com> wrote:
>=20
> =EF=BB=BF
>=20
>> On Feb 1, 2025, at 10:11=E2=80=AFAM, Peter Zijlstra <peterz@infradead.org=
> wrote:
>>=20
>>> On Sat, Feb 01, 2025 at 07:47:32AM -0500, Steven Rostedt wrote:
>>>=20
>>>=20
>>> On February 1, 2025 6:59:06 AM EST, Peter Zijlstra <peterz@infradead.org=
> wrote:
>>>=20
>>>> I still have full hate for this approach.
>>>=20
>>> So what approach would you prefer?
>>=20
>> The one that does not rely on the preemption method -- I think I posted
>> something along those line, and someone else recently reposted something
>> bsaed on it.
>=20
> Here is the RFC I had sent that Peter is referring

FWIW, I second the idea of a new syscall for this than (ab)using rseq
and also independence from preemption method. I agree that something
generic is better than relying on preemption method.

thanks,

 - Joel




> Tying things to the preemption method is absurdly bad design -- and I've
>> told you that before.
>>=20
>=20
