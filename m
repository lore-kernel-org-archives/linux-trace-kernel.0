Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C539137C35
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201795; cv=none; b=isPAkcgxXsUVBbe9OPokO2JHaoPUkTByitL23Y+EjxQ9QQJdwUZcOpr3tGI5WsYkF29DMi9WKZkMY7P0XciGqHY4TgvAsBETcTwdFQkuZmYq12JcLkbxku6872LLGnMkKxBrPqdh/ydD7HDe7sxY7lv11akH5R1o+clBNKylcIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201795; c=relaxed/simple;
	bh=v8/HTNItQv0TG3Sq4pBWyyUhzG9Q9PL4uVQLQoslvow=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=YhvZHcyo33vBUoWCq89/4pnX+MLq1V4F0Km0cfqXBXgbar2D6gYzNP79a7SAcsNjO3yqVnybtdyAx0byU5msdVjlMUhRB9OQ1QUkfvkZ8dAoGkBe0EfHfAc8ChuRJwNaBfCpSUSGPh2afGZeBTn9PdbsaIiWIjbBs8urFEQybAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=jNzDigo5; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="jNzDigo5"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e580256c2so1088137b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1729201790; x=1729806590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lu/dxnXAMTzuUeZdFobyXdEI/zCxHQSZLPRWhAzrc2c=;
        b=jNzDigo5RnJypPmAVL4yZhn2gJsp3RXxoi2lXkQUfZGYcQhIqIRUWhn8nyYDuAfWij
         lBOI9Z88xP5FatA0G3OI4+tJvJnkgQWMFoY/BrqP8+ajzdzkiY8Z/7P+a83ZW0kgSCaN
         pvhJWEjd+Sll2/WyMqdVrLUE617uSPiBXTlzpA5We8rpOFyppNwz/oaJG/UdAwC9hR0v
         cLd9uC9h0CdQiJo8cCXlPN7+rqSZwrmcz/5G9DJn0B6XdKzvg6vievWwT1LHxD9k54m1
         A5IxMTmU8+wdDZgvd65XzdeoR69dv+lW0CBVAuGePikYdcDPiSIDP3F3Rz+X98KygW+i
         YclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729201790; x=1729806590;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lu/dxnXAMTzuUeZdFobyXdEI/zCxHQSZLPRWhAzrc2c=;
        b=JCLvVly+4jWTAd2zg4kIRi17ifYYneKLdBFHQfNuwPkQXfcamfjLbBLsW27IduBCLh
         5wKiaKbUHqfA76G7XDLX9r7fwPY0KKCBfBWi8tvmKacYORT0ldspJNj2+gNBpxoKt57x
         /sYOWKvPYIf2H67/gSyMOVH/NZWTH5jptUtJHNcIkBW5Uusnn7eaqu6fZnfCeswPvumS
         l9O7Sg8VPwY1aRdfsKSdPdmCfGNK4Kbj+1qxIthTYv5jr7wjT6HTUElPLRr1JCNGFVzV
         tSbaa1vDNwd3EFAydLzmHOrnE/FRWSuSf6xHsbuxfKJSE2EasawN0wC+09lu8Eh8Wg2b
         zuAA==
X-Forwarded-Encrypted: i=1; AJvYcCV3hP6ooM1TH73AqebH+tEPq3BeRtMxs0Afh6U0BgPXzmWvKbSKqcePGoENEdiz1IVko6qgHDeYFw7G5Th9axi+wmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGgAGCBs3JdbP+aLwtOntQsWpCFLoyJg9qsxnCpEEnTWt30FqM
	b9lEHkj6lhL1TtOePS7g+X707k1z0Q+gc3BWthkAp/93U4tT5LKaglLYjcgK7dk=
X-Google-Smtp-Source: AGHT+IGmY3bCaEMXb29cCY6tmaZsUZCoNqD8MeKKY+vFnpDezuSI2SqDrji03CqXJjFB8/1kPsAZ+w==
X-Received: by 2002:a05:6a21:114d:b0:1d9:2c23:66ff with SMTP id adf61e73a8af0-1d92c4ba7aemr371347637.5.1729201789678;
        Thu, 17 Oct 2024 14:49:49 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eacc28baa6sm80732a12.73.2024.10.17.14.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 14:49:49 -0700 (PDT)
Date: Thu, 17 Oct 2024 14:49:49 -0700 (PDT)
X-Google-Original-Date: Thu, 17 Oct 2024 14:49:46 PDT (-0700)
Subject:     Re: [PATCH 3/3] riscv: add PREEMPT_LAZY support
In-Reply-To: <20241009130530.2Sv2p0Eo@linutronix.de>
CC: peterz@infradead.org, linux-trace-kernel@vger.kernel.org,
  linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org, juri.lelli@redhat.com,
  vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
  mgorman@suse.de, vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de,
  mhiramat@kernel.org, mathieu.desnoyers@efficios.com, jszhang@kernel.org,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: bigeasy@linutronix.de
Message-ID: <mhng-02463d30-c55e-41a9-beae-ac4cdff9fc9f@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 09 Oct 2024 06:05:30 PDT (-0700), bigeasy@linutronix.de wrote:
> On 2024-10-09 15:03:07 [+0200], Peter Zijlstra wrote:
>> > diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
>> > index 9c10fb180f438..8b5a5ddea4293 100644
>> > --- a/arch/riscv/include/asm/thread_info.h
>> > +++ b/arch/riscv/include/asm/thread_info.h
>> > @@ -107,6 +107,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>> >   * - pending work-to-be-done flags are in lowest half-word
>> >   * - other flags in upper half-word(s)
>> >   */
>> > +#define TIF_NEED_RESCHED_LAZY	0       /* Lazy rescheduling needed */
>> >  #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
>> >  #define TIF_SIGPENDING		2	/* signal pending */
>> >  #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
>>
>> So for x86 I shuffled the flags around to have the two NEED_RESCHED ones
>> side-by-side. Not strictly required ofcourse, but...
>
> I can shuffle them. I don't think the riscv camp will complain (saying
> this for them to actual complain if so).

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
