Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AB22EA154
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Jul 2026 07:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410784; cv=pass; b=LnbMvlTiMdyiZexInTYdibbFrjyUU0Jqq8zoTDDSTzESPWENRr1iSTnZ6e0s6/KTIMg3vyCJsw7ZS3/KE3P5gODnCjvKK9JhdiYntfImhi4iUT6aOrbBTdzZGHyiEnzoGhiMI13gZfa6Sa+H27sSjvy67Akc8esJ/yzlH5U+6xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410784; c=relaxed/simple;
	bh=ZQUk0UfnaGyun+ByKFQ6mKbppq2aWwvLE1JvvXQvFow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/D6SWkoODPGHr2lzlQfLUeYfqI+boMVI8y/up1D5GXhVd4El8mp/7fD9Hkjue/E+kYGRMvNFPtvkpViamDdS5au5BH0P9IVhw0YNusUqaTCCSVwX9ED6srR2TxkVBBrHenw64v6qhVRPr/unoTZ4A7bywApgsfHYrkVexuAdXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LiRL0IP1; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LiRL0IP1"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c16ac21acso18765721cf.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Jul 2026 00:53:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783410782; cv=none;
        d=google.com; s=arc-20260327;
        b=K216EFmHYATSVloMj8S2YOEMhZTqH2aB9W/3GXfOd2u5vY3561O2W+mTJjNZzh6IU4
         zLOEoP1WsJfmkFRVE3GSDqLSQ/LXPCJB4nEQK1maWVrFE0G9vmi6qjMUwZdoJsesIsr4
         zt+usGk/Mhe0/7GHuQar8sSP2GbrfwvHPuV9uLjoTVUaVfQpT/sAq8YnOReGl4uhKc9S
         PbW1hGia715V3w4FyFtBAKlJ9d/9uWZNFjJpybPylP1eHzOkTKwyn9n6Ce157iJUngSJ
         e7z0DQAkqB1OCfdZVliAt1C09lkDq4dkKWhTESHQ7EePLWWM3/NkGTiXsMAPjJHQKFMm
         YHUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9y+HGLwWZHe82cGq92fBiAG8Z2PP+p562QyKY550vmc=;
        fh=gaslhG1FChPSrelZrB8drpUwVmm4gGX5w8ep8EIsFQ8=;
        b=Cj9Q9GtkPJ+Bu/OVwkOTrkIZzVBUNifIiHkMPCUTPU7qvZuG2LkQ0CL6jGFRIEjQSK
         JuvpNzLh6QKlHlBa9QiLd/ktGMSHb9dE+tlZQ3itxQcLzDjNmbqp3+P/aAoHH6PNC/I2
         LK5woUBC4nhYJWRKNBobBqepLvi0FcNqN0doBzPJwKsm5udY8tBnc+RanGb6Wl7du2b2
         QKBoqb/OcT4rReSx/MvyGpOKpuisVqDf2meB2DQZCqslUPiOOXYiuLIy0HRduw7P+dCl
         b8SyMABa698bvwz52GLoTaUoa7Er342vREF9EfT0eYtrKNceYhA1QNSvQO0kYt9vGgLH
         3IPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783410782; x=1784015582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9y+HGLwWZHe82cGq92fBiAG8Z2PP+p562QyKY550vmc=;
        b=LiRL0IP1syUky/B5GtAB0E/Fg7wrcc0peXRCMgSR9+ldN3sBKPvnc/wudvIuGSQ8R1
         NF6F24fZovBXGwa50xWQjFMLtY4TLDm1N69UjiWBFRbJk4/wnea1ZOW9F5u9cfiMNMtW
         R9lfPCqHysggaTomlq/mFobzM57aJYY6axGeLJn2Qpg4zxnnnPD8/yuF+dVMZBTaEPfh
         XzcsESpMDpV+g/uOrlfg9syEgNfb1TLO6HvvJHfxFyEUdmNINIiH9b4alyyGFKlqxeyC
         jDt/3RvjZlk/9O1o9tLRsJnR8X2gsVpx7Fh5xABE1Ova2Bgn7jjfCjcixbDu5kh9yMg1
         3f2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783410782; x=1784015582;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9y+HGLwWZHe82cGq92fBiAG8Z2PP+p562QyKY550vmc=;
        b=BsIuGAj949QEWIXRNVJshbZpEmUGOHUrnn0W/Lf1ddkRlQUgALcLLDYZjuXr527jO4
         +9WY3+JGGFRWiinq5qRRP70TpZupI2V2u9slc92b3R8hUY3l0a2ESJDhPXNB1J0r16jh
         hXKkd5QndW91tKF0JFD4SLaLI3HuvKTvfq2Fa+xmkuLArhpiC5JQEA3sLUvL8hHj+1v4
         9FZAdISIgeZbaEdeApRCNXGqzINzW1ude/d58opx75X38HhG/+WpAE8gGUO9KbM1T0AR
         CQDg4kkApOrPIYvUM25ftrbPlFH1Kq42GW6jVhCjBR7SsmB1JhkPdxr69XgsZCW1up/5
         n7kg==
X-Forwarded-Encrypted: i=1; AHgh+RrFWyH1/evLyXl/v3PunHReASXjDB4I67PKhs//2Ryw9svHx+f8R3PYegmtWwuTUbZUncQw4mT3XPoS7GbTcSBQaqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUIjjSdag9SLGNJegd9VjOn+yr42K+tyWC0cVyNLSvZ66Ja/Tf
	/FWR0DPYQfNqSy2U3r36aFJUdczC4kHtXb5B4qQs5deVV2NFg/GXFX2LZGCaYQbvY/W31tE6pXq
	/jXo9bviRNBl7ntbtK+QnPFNHYbKRBCMmG6MDiNEmYPnhSVPlpL7h4A29Ys0=
X-Gm-Gg: AfdE7ck8tl/teYssBaTe+1rztuzMsuYQeMKVfZHhbTNRBIY0L6LcXFsJm7tSe/etDOc
	5NjTlyTP1ouO18QJyUZDpEnHlX7qn4J+KgWQWW913Uz2I2A7YEF3OGkDgLIGMIYj3D5Br7GzcHC
	KFZeqs34vHI8/xOKA86eTV6er37JQmOwDZhRXGuvtwXfuG1Dw6hPvf+LT19lzBcRPBkNRYKjtXK
	rgvJ09jT2QcP3rSDoFNn+SHHVIRkJ+W1s5eSCOnWeu8WWk1C/JbWGgaK1FiGMZHYqzUdiBqWv4o
	9qCiEeKhOKljudksrJum7P7fLLhBJC935H3uSqwUd/pwlQCtXm2Yo9W4he+umL5n/W9zR6g+Ex0
	D8LLeB2jOqg==
X-Received: by 2002:a05:622a:5a10:b0:51b:f340:d2be with SMTP id
 d75a77b69052e-51c7487e0cfmr46160941cf.53.1783410781438; Tue, 07 Jul 2026
 00:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707010151.43976-1-emil@etsalapatis.com>
In-Reply-To: <20260707010151.43976-1-emil@etsalapatis.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 Jul 2026 00:52:50 -0700
X-Gm-Features: AVVi8Cc2_RGmZHcnmBvpweCTGkIVDH5IqtiixKASATcFwOxN0G0PE2Ov00rUo4g
Message-ID: <CANn89iL23Rsu3iGXxhw4pAnCB-JgU7fnrryDLXKj4jHqSs=HOw@mail.gmail.com>
Subject: Re: [PATCH net-next] net/tcp: Add explicit tracepoint for tcp_syn_ack_timeout()
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	ncardwell@google.com, kuniyu@google.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 6:01=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> Clang can inline the tcp_syn_ack_timeout() function during compilation,
> making it impossible to use kprobes for tracing without preventing
> inlining. Add an explicit tracepoint to it instead.

So much copy/pasting for a very small issue :/

>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  include/trace/events/tcp.h | 72 ++++++++++++++++++++++++++++++++++++++
>  net/ipv4/tcp_timer.c       |  3 ++
>  2 files changed, 75 insertions(+)
>

tcp_syn_ack_timeout() is hardly a fast path, so you can instead:

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 322db13333c7..ab2c3de19e46 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -748,7 +748,7 @@ static void tcp_write_timer(struct timer_list *t)
        sock_put(sk);
 }

-void tcp_syn_ack_timeout(const struct request_sock *req)
+noinline_for_tracing void tcp_syn_ack_timeout(const struct request_sock *r=
eq)
 {
        struct net *net =3D read_pnet(&inet_rsk(req)->ireq_net);
