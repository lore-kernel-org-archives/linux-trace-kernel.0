Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1AC1D555
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729688498; cv=none; b=NBo6p2QbnYuuXzoSpi7f2ntZpcXQRU1YE2AM3vXDBLNbQQWtUU2UmnuMTEqewVfcQ02aIB31eU6Nlwidp6Y2+cnVJtEqlih0me23rx96xX2NV70L9eO+A8V6+9bzVPbpGXnNjDXxHwUCfKIoU70R+MnZwnZnz1BZYYz6ftHhgkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729688498; c=relaxed/simple;
	bh=nbmo5aGA7LT0Hgov1qAGwKoPu5C3RFLgaH6+HqPHBBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAwaFoCwamFZArg9QhkITZAo5GySka0aLD1JZGcHgccp946XAjvN7ITnyud/Mdrk5cdyZegJl34dpDpYFUAm/3BRptgVrfYVJQ7yXAyXDdWr7VpJyc3C5EYDPo29vC8npC4Pp5jh1rheDlDUFRL3ImYI5b+FF56oQyJ4J9JK8oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZwKgjnpG; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZwKgjnpG"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a99eb8b607aso734797866b.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729688495; x=1730293295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbmo5aGA7LT0Hgov1qAGwKoPu5C3RFLgaH6+HqPHBBY=;
        b=ZwKgjnpGbffcnVl712PAV41xilwX37reIo0QhMQDjvIgRY0rNjqgy7087dBpAIFgma
         O+R+W+xo2DIV2BrvIagxxx4hupqYp4qRW8P4mB1DxnZ3VjPMXca2oaV0X/eST0QKP7AF
         YZ0XevBOu2wTTN8iV/TjjMXlyMpaW6CuVvOmJ3jzsMII1XDqNah6xq5PndCMWQz9afx7
         b3+Ty30nISli+8AksENZCtG0I/T0O2Puhi+b52T9YPoe3VobrOmBDN2kHmrvimBLWfWZ
         t3ZADQxYl9RrwZ134vG5AdicsGZnRKb7M0DzSxsAJmLBZoLOEeUgixjzlK7hCP1Gj5Ob
         8X3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729688495; x=1730293295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbmo5aGA7LT0Hgov1qAGwKoPu5C3RFLgaH6+HqPHBBY=;
        b=uwhYbTqcl31T5oEnxD+RA5nE5FYnCkVn0+oeIPwEHY1HV5divtkufBIQx0coAgn1t8
         pZJQPoR811Fe780whhQKAqXpp8hVchiGfDpF6zdQ5F/YqG14SIbknvZWRAMkfs0OeVXl
         OqjsarGWXeBjlik/JfaFZ/uBRMoCt8RVm+vx1v7xKXQ3cGzg7a41G7rTgT5AUegIgM8r
         xh1uPN4hMSShvP/zEMg9yEMcPrAzFzkKAsM5pGUMwldKADPnvtQoPM3eL7rFYcv8k7Yj
         fpDmlgRHtrKUF9IHDEr34N5X3EpnxbAfWekPxhhutWn+SzMD8doINwPZjyL6O7abRq1B
         I5sg==
X-Forwarded-Encrypted: i=1; AJvYcCUTOtYy1aWzbMZS1UBa5a/54V2iHPLsqycMhDcEGEj5bb2FhWxidAEI5m+QTteWsq2ljVPgV7mFBNptjpFr21br66Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnVhw98CHsEKwEA7CS+Dw6dZoOP3T6JPHpax/H/OA05/V2CmGx
	MwBigqaT7vCoxIEUJrxgip/eddGBXknNBos2eUyUdZKa45tjcRfoVVDyV2BuTllWQVddNza6GL+
	kQJeRI/5E3LgS3Ulho2ysDVLcM74YfrvnTy/t
X-Google-Smtp-Source: AGHT+IHT805g+LbGy0EqqXtuxcuYkq9Wu1QcCa4o398B7x0nju7lBTF/vbBIneUpiRF9UyUOqDWCaTIvci00Oy8nL28=
X-Received: by 2002:a17:907:2da6:b0:a99:42e7:21f with SMTP id
 a640c23a62f3a-a9abf8ab018mr221805366b.37.1729688494348; Wed, 23 Oct 2024
 06:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023123212.15908-1-laoar.shao@gmail.com>
In-Reply-To: <20241023123212.15908-1-laoar.shao@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Oct 2024 15:01:20 +0200
Message-ID: <CANn89iJuShCmidCi_ZkYABtmscwbVjhuDta1MS5LxV_4H9tKOA@mail.gmail.com>
Subject: Re: [PATCH] net: Add tcp_drop_reason tracepoint
To: Yafang Shao <laoar.shao@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Menglong Dong <menglong8.dong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 2:33=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> We previously hooked the tcp_drop_reason() function using BPF to monitor
> TCP drop reasons. However, after upgrading our compiler from GCC 9 to GCC
> 11, tcp_drop_reason() is now inlined, preventing us from hooking into it.
> To address this, it would be beneficial to introduce a dedicated tracepoi=
nt
> for monitoring.

This patch would require changes in user space tracers.
I am surprised no one came up with a noinline variant.

__bpf_kfunc is using

#define __bpf_kfunc __used __retain noinline

I would rather not have include/trace/events/tcp.h becoming the
biggest file in TCP stack...
