Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9DE245033
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Jun 2025 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751274716; cv=none; b=TII78WdxXDyj8xVWzvK82/qx9NECaOPsZNmigr6Ia9/uGfYNg/nFbErAX91ozWNHB5ragvvuDaY5PMV03SEsY0K3xcER4J2q0VYd8hxZsyAhcghbX2d2Zs5Iv27fQ8KdTZ9tYk3WeR140yFbhTx7okyZOIfsfpiTEypKfX7ieCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751274716; c=relaxed/simple;
	bh=NHJzgU0aQXfK39wYCmHOvMeydl7411silGVJgkwozwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dfg7wok2MKxhcOAFJkpF2x4GExy+P4VbxHjei41lqgh6bOfSMJspDzGKdImWQ6UI9A8mPomBhUhf790BWgkXFs7r8pu8H2XTlqsy1JWakdlWvT1+c4qoVJvJ+EPc1Hp8lFhrssyikAcLuhVO3wD/puDUJEqwgMVXRi1Xec+7ZD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tXfSVQ9r; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXfSVQ9r"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a58f79d6e9so58580561cf.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Jun 2025 02:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751274714; x=1751879514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UU13DdMIaksh/X1KjKcl/Raj5wdqxWH1R0ASLRmV2M=;
        b=tXfSVQ9rNVLvEQn/S262F4MAUbzK3EX67lMCCkpm0foF4u9S0N1ntvvwqJhR4Fvn8W
         ClRbpQj+cfoLPAh2BIjvopomjlurSeL+vBSwcR/CasXCW1VQei1PYpRcmtlhNq86iZa6
         ADPVUDq0hjBQ8Znj5LxNq3ScgZeUTYoJXkA50l5dXqd7f8YmuJZwQvSAIsi8YZa9igto
         g+8vY4eJDVMc3vwmDbxsk/B3gMd7eB/7Ch/JRUycJ6IfVUuX6zorePzWaDGGz4LBE2Rw
         /Em12r+Oxt84VffUz4VNzHqY+jZfnJOXYNoOhUWsk9rHa4A51HYMGGZVijfjzt2MLJXM
         Ev+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751274714; x=1751879514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6UU13DdMIaksh/X1KjKcl/Raj5wdqxWH1R0ASLRmV2M=;
        b=q9Rh7cK4n554CbglpeuORWgJdMvMJiFoD08TlQvsQR78mLX0YOlyqU4A/3CFBRfENs
         W0pH3xT+GvhEGBfQqHFeCnAMG7t7sgBbIvQWgYqM/NtL9vvhT6hv1IRHEgLa5xAB/l8I
         VcJTmqpvdBLEu/9npCZrl2H4LGoB7sXVLkFLVcGpaksQYRNhs4mSF4a/CXhvZICdjDJ3
         27P0f8JvHFJKSuGat/1U4Ju+TgczbpZ2gmZq4tF37na1S36XLxJAu4suYdrxbg7kw7t1
         QmUwNvW+q6ZaEZrDBhmV1XF0+tmpnx3EQRS3t6/KGvP9rj+D224I2J5A20+zSITByBKq
         HP6g==
X-Forwarded-Encrypted: i=1; AJvYcCVzdd3RrCrWXxSgUM/JpWih/TrdQOA4i+0vcJnJtFK9E2U5vx2GpryOf3PBWuwmSLDTLjo97o8ldVOd/AhB4+kHwsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0KQppfjntB2wgSqM9JNr7RYET2NBtracVJ4O787XkBrqjJvfA
	dCUc/D4z83MWw76kK9ceSSBu833hzEcQw+62MemaqDB15lcwh3wzUHIbfi/EucdJllnNDpNUqHQ
	ELwynEkMVbs3VydXvwIufEObnhVZxaO78TRpUZI9K
X-Gm-Gg: ASbGncub16LYbkcbx0KlGG1wJ1hjlym7Z/bKtokI4p0BAuM+rRMagybg1aQCNVKoJcz
	m9FVMmyj/IDc86bDr+U69g1M+cYD+b36UU+sUmtItha0LB1Uke1l+0RkLrAmJyVa2+Mnchx7vbr
	I4jvbIEm4y3kSK31UI++PYTMrUmmJxw6OmH/6eOOLgh4xPJbICQnvC5g==
X-Google-Smtp-Source: AGHT+IH4S1MS+PwPXkrKUOVhav123OJMtGMBPV3RNEHzL2SXQX+WgUbIwZMUSECufylzadW0GY39deoW/5+5+fET5lE=
X-Received: by 2002:a05:622a:34c:b0:494:a436:5af6 with SMTP id
 d75a77b69052e-4a7fcb12fcamr225013811cf.47.1751274713821; Mon, 30 Jun 2025
 02:11:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025063016045077919B2mfJO_YO81tg6CKfHY@zte.com.cn>
In-Reply-To: <2025063016045077919B2mfJO_YO81tg6CKfHY@zte.com.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 30 Jun 2025 02:11:42 -0700
X-Gm-Features: Ac12FXx3UzoZ7hTWdmIYc8ImdO8NBaHRWiXy_DXplPKrL4pToPVr0gT-jxkA6CI
Message-ID: <CANn89iK-6kT-ZUpNRMjPY9_TkQj-dLuKrDQtvO1140q4EUsjFg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: add retransmission quit reasons to tracepoint
To: xu.xin16@zte.com.cn
Cc: kuba@kernel.org, kuniyu@amazon.com, ncardwell@google.com, 
	davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, yang.yang29@zte.com.cn, 
	fan.yu9@zte.com.cn, tu.qiang35@zte.com.cn, jiang.kun2@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 1:05=E2=80=AFAM <xu.xin16@zte.com.cn> wrote:
>
> From: Fan Yu <fan.yu9@zte.com.cn>
>
> Problem
> =3D=3D=3D=3D=3D=3D=3D
> When TCP retransmits a packet due to missing ACKs, the retransmission
> may fail for various reasons (e.g., packets stuck in driver queues,
> sequence errors, or routing issues). Currently, these failure reasons
> are internally handled in __tcp_retransmit_skb() but lack visibility to
> userspace, which makes it difficult to diagnose retransmission failures i=
n
> production environments.
>
> Solution
> =3D=3D=3D=3D=3D=3D=3D
> This patch adds a reason field to the tcp_retransmit_skb tracepoint,
> enumerating with explicit failure cases:
> TCP_RETRANS_IN_HOST_QUEUE          (packet still queued in driver)
> TCP_RETRANS_END_SEQ_ERROR          (invalid end sequence)
> TCP_RETRANS_TRIM_HEAD_NOMEM      (trim head no memory)
> TCP_RETRANS_UNCLONE_NOMEM    (skb unclone keeptruesize no memory)
> TCP_RETRANS_FRAG_NOMEM       (fragment no memory)
> TCP_RETRANS_ROUTE_FAIL       (routing failure)
> TCP_RETRANS_RCV_ZERO_WINDOW  (closed recevier window)
> TCP_RETRANS_PSKB_COPY_NOBUFS (no buffer for skb copy)
> TCP_RETRANS_QUIT_UNDEFINED   (quit reason undefined)

'undefined' ?

>
> Impact
> =3D=3D=3D=3D=3D=3D
> 1. Enables BPF programs to filter retransmission failures by reason.
> 2. Allows precise failure rate monitoring via ftrace.
>
> Co-developed-by: xu xin <xu.xin16@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>

Problem is that this patch breaks the original trace point, without
any mention of the potential consequences in the changelog ?

commit e086101b150ae8e99e54ab26101ef3835fa9f48d
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Fri Oct 13 13:03:16 2017 -0700

    tcp: add a tracepoint for tcp retransmission
