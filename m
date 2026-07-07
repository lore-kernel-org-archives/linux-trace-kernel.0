Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F029F3E5A2F
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Jul 2026 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783440527; cv=none; b=nTAteSIJ9gJhOrIZNjpd5RbuDOjhT2jpcplxvUZQm+RX84CnkVVQ4DRA+C5WnBI5WXB+8rOwiQ/SpguRaD/XpCfwVT1BlM9Npr8Cnarwe5lZpJJe4pngS9ukI1OLh2F1f1U9jPVJwOAks/W3eRqCJRCEwVGwhSDg+PWMBoLE58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783440527; c=relaxed/simple;
	bh=gYxQlABoejgiGiTs0GRyEyflzw66+wYXuoHMbNI/GrM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UcoFQh5cUJk2ilLJFPh7uN7PsbwTpMt+erAh2ifo/9oQwIbatKeCryzpcvBSKws9swx5/2vJjBfZZxPbme6BFxPFQ4eu3xnLenToVfPQYYcf35F+RTtZ552RG+nklODzY+OJhiSGkyUY0S6vFAfB2mtLLiDbMsfpkyfIXsuCcX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=qglFq+XI; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="qglFq+XI"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-845c92bc464so3286791b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Jul 2026 09:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783440521; x=1784045321; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cMBdmbNnt7rGb9jJRQ/x9X78dUBABwOU7eEiSX3Y2u0=;
        b=qglFq+XIBoKUrYMT9baCl3v1fz4wb0pELGnXGKP7XEigyAUpuSkXsUrGqZKgYziI/1
         9NTbRYQ3IQdM1Hbu8XKz+972Q3zAAJmOnMFcmr4hk8S8o92QpzkHwXmCV6MyQjA+nk60
         HZE/5To2G44cRai4C3GSS0PcYl2ge2u7t5YBRUKdAM/h0rj2ymYcRiuQ6I9az0E+p7dt
         pKhDxPh12FvC6qjVMr6U9O8oh/6duPDb7yJliFroU1AkeBnjEd7VLEHugA968PGqcbRY
         I7Nd8bNANBMJJn30ZRLtf2kaMIbk64fD7f4Iwpn/vOV/mw1qTrwwQwz24S9/pplZFknA
         2oMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783440521; x=1784045321;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cMBdmbNnt7rGb9jJRQ/x9X78dUBABwOU7eEiSX3Y2u0=;
        b=JVMTud6DK41KIQkiWG1iHiguulrEJTvEsAplVsJ49HTbBESn4FtRJM2SXmWtPz9Bvw
         STHxBWCLt4Ygr+5qGd6kTYjLmk+rYANMvNY+ZmpT9xCnNEf0zAOclkSYna0Z+CjYCbfp
         4XFrjSbEQzdy9g1T+O4fKfbbrbXjZoesiE3/nAD4noEV0hOC9IjgHaHHGJ+7Jyx9Gn9q
         VAx1jUrRpBbK76HRIVNyqpXBK/sT0UIA4PY1Xz2zZtZF/atgicIxc7wwKmi3TPJVkV2+
         1WqDjxwUEo+VH5j9AOKguIFEA2+LqrrnFQy3NHZa8RMIiUfSon+7Rd+2ku48mrYorL4H
         ie0Q==
X-Forwarded-Encrypted: i=1; AHgh+RqaovC3JpQ6Wrp5y+i9jacS7w4kclK1S3YxhQbkWRu/TMCNbHFe/fHxf2a7Za9MQa4xDHq5EN5K0hfHHnVQB/VCxHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9W6v1VxqartyrbR8B8KZs3mqws10CWCMe+lzSRRDN8CmNbcGz
	+hCepBty/QkdgZ9H2ELUeRdJY9R506D8tH9/SRXez4GJ/thJ37KbHqNFPieicbQWtb8=
X-Gm-Gg: AfdE7ckDU3OFEBuVKRK1PnnjjRKo5afmw7V5QNnmvoilL9DSIEh+Dhbtcv6VyIcHF84
	Q+7W5G/fW9GSR0yMwFIuPrbmqERc9HvWGlk9OHrqr4ZROye4JUocFduxFy2ic0iL6qJX/ox1WD2
	WtxtE7gZnthqV/FS1IEvlysB0wmrSZWcBCx+Lr2X9UPjelCk2JiUkOw/vmciDuTaRg7A+d59l4z
	Dv1yaef9p7IZt9hyPphcnj5xAnTS0E/nguDsYDJnTXyw4FUeSHD5dhFd2nyjhLh7AE1DnwXjxfI
	2+xx+Mgt16jBzFiT0JM0hAv0FBKBy4Tg1yVzPJnSstr0v/T1u9CdHgNfIcy1XXQ/U5/0L+uDt7X
	3mSLNv2gI3tyhbdz87k5OIUHLr7V0+i1qvSabU+nBSa3KZc5kLqd3JvK1E9ku0qLsVC2CDOmCfN
	SH9KnBe0y4NRiB6qv/aqrEDlBNVAUKHXYp0M6x8mhfm8NmXnZrQNix
X-Received: by 2002:a05:6a00:987:b0:848:2f74:1d59 with SMTP id d2e1a72fcca58-8482f74207emr3285927b3a.63.1783440521110;
        Tue, 07 Jul 2026 09:08:41 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6bc9f5dsm5702549b3a.27.2026.07.07.09.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 09:08:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 12:08:38 -0400
Message-Id: <DJSGWFQ1Z86C.214O720ENTA1D@etsalapatis.com>
Cc: <netdev@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <ncardwell@google.com>, <kuniyu@google.com>, <rostedt@goodmis.org>,
 <mhiramat@kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net/tcp: Add explicit tracepoint for
 tcp_syn_ack_timeout()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eric Dumazet" <edumazet@google.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260707010151.43976-1-emil@etsalapatis.com>
 <CANn89iL23Rsu3iGXxhw4pAnCB-JgU7fnrryDLXKj4jHqSs=HOw@mail.gmail.com>
In-Reply-To: <CANn89iL23Rsu3iGXxhw4pAnCB-JgU7fnrryDLXKj4jHqSs=HOw@mail.gmail.com>

On Tue Jul 7, 2026 at 3:52 AM EDT, Eric Dumazet wrote:
> On Mon, Jul 6, 2026 at 6:01=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>>
>> Clang can inline the tcp_syn_ack_timeout() function during compilation,
>> making it impossible to use kprobes for tracing without preventing
>> inlining. Add an explicit tracepoint to it instead.
>
> So much copy/pasting for a very small issue :/
>
>>
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>>  include/trace/events/tcp.h | 72 ++++++++++++++++++++++++++++++++++++++
>>  net/ipv4/tcp_timer.c       |  3 ++
>>  2 files changed, 75 insertions(+)
>>
>
> tcp_syn_ack_timeout() is hardly a fast path, so you can instead:
>
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index 322db13333c7..ab2c3de19e46 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -748,7 +748,7 @@ static void tcp_write_timer(struct timer_list *t)
>         sock_put(sk);
>  }
>
> -void tcp_syn_ack_timeout(const struct request_sock *req)
> +noinline_for_tracing void tcp_syn_ack_timeout(const struct request_sock =
*req)
>  {
>         struct net *net =3D read_pnet(&inet_rsk(req)->ireq_net);

Sounds good, I will respin and just mark it noinline.
