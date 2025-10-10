Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BE02248B4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118625; cv=none; b=lfm13Q9fC5f69RWlL6H5XebVxfDuvYkAI+x2yuLrW4tyOw97NUV6MHpgcdgVrQ6chMcn/mNkDFzCtZpEH9O/HhcC8fDtYxJJA6PsoKshmlNK2pRXf/vRm6hHUMy2FUmJxWrZyx4yuTXOFgB17eFzhAxCvJCRTYxUPrk4qrpMv3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118625; c=relaxed/simple;
	bh=rLfW2f2M9XNswFGXljZ3Iduk5Ck52EhLpoddlrpwCU4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rms0J3tj/1C1pEB3wGcXyHmC/U09+X1xhehH6ePj49u8H0Hv/xtHjifFtyiSqPCXp5fxvtUJ8Ct9lQLy7W+SF/M0ElwzvapVMuDvrSBJIfhHONreAn2ZJRZ8RVZ6y6IdlehYFbIdgFDUx6hPoiRiedo8+HAH2A2XZTIOQsSQFrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RcE8I4mV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RcE8I4mV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760118622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rLfW2f2M9XNswFGXljZ3Iduk5Ck52EhLpoddlrpwCU4=;
	b=RcE8I4mVNC17zoHXeOymYLoVpZnLDdhz9XkrA/fX9AkLaoEKz23vxdFCn08s7zY40VD3oF
	26/dXpZR19i2HrhFeZ5mTQbsIYX//CpcpY/t/mJ+nlM6jO0NCOq2OHCvDpNyJ+pA59qoqj
	f8mB35EttG0ImatnptAw4Y3KGeWgRhU=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-haPUJR2BM6ScnTVyNJOuwg-1; Fri, 10 Oct 2025 13:50:20 -0400
X-MC-Unique: haPUJR2BM6ScnTVyNJOuwg-1
X-Mimecast-MFC-AGG-ID: haPUJR2BM6ScnTVyNJOuwg_1760118620
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42f67904af6so153255415ab.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760118620; x=1760723420;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rLfW2f2M9XNswFGXljZ3Iduk5Ck52EhLpoddlrpwCU4=;
        b=dDIbMNLerKGSPWvDJ9LoiJrfjQ31FHNj3HoECqCTWEXnPwWejgxH0YRcuueTTwKcBr
         TwC4ITFAurDJuO1fxRcKpXGw2dQaJrjmEvqiKYIEGVhM2vQxXpgpD8r1CmmNDwHaLrXy
         JJxaO2i1e4FBPE52h8sqtwBUjyrJsJu7CLVW/tXZ8YXHKk75XQOftosnDVPP2MENTmyT
         CmuegvNI2451tBnP542tZG3rNnRHXIsccaB522ZnbGBh/yf5vDZ6rpNFVzSPtBcW4uwd
         2LFbpBQQU4Wvj5F+3kIizKvVO6SakSLNGfC61SfIh4HZ9065557FUmu9RwLSPLOWR/m/
         CRPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRr963fY/ioK/UQkiouwpdVn2k4+e7F053SdGWW3hhrVRpg2xJS+vj70jVCWfqNDeVYJWYsr7gswxT+AI8TENCRSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH4iFSSiodr7qECru6QVkm8kvZ8y9NGdHyJlc4+JyJH3guHGPE
	yZuvMFt2QcTUKxbAeyInbG8LoVTPZVjNUSNHqxl9dbvLUXwD97hdJhy8+kzclVef0aJVeCDZzqT
	QEEC87HkZNwxVA5joQu0aNmmUSuS5HtXX3QHLjq6XAtd3OWThk3pFVQTYQjY+m7bgHL/fo9IQUA
	==
X-Gm-Gg: ASbGnctc05wV6xV5LLwbveXBWEsaM8tqJ7wWC7DmZHnc9abRpD10ofCsceVNmDps/62
	2LmxXYE/dPkq1VnuGxlbGTY9XdYNz7hYRycJXQuwX/4ZBrtwB2b+hBOqoZBXgzmK5lLqQD0HiEZ
	AJyXGchlrXJ78QmUqClNiYglLCv2E+wD/F20JFmX7W/n5DQkyyJpqLO4MurWaM8jbCjDV8hl9ht
	jgek/MT3nCWLJZgwUs4Wmn05Ff3ozPUKUkbqUxWhYX1a0AfSgjnPUTYAwC0UK4DoynRxKVooR66
	qZvG9TXVD6bNYBEoTiBMUndvNk755INeV9uiGX4QobHCVCTvLuLLOJf3H52Tg0LPIVBpZnKz
X-Received: by 2002:a05:6e02:214a:b0:418:3b13:d810 with SMTP id e9e14a558f8ab-42f87369997mr124814685ab.9.1760118619695;
        Fri, 10 Oct 2025 10:50:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuEr1LbEgCdvx7M0g4qU2T30kNZutU1XAtlJUA2qld1e1AJmZAVgTNchwHGkxRss8qWACILA==
X-Received: by 2002:a05:6e02:214a:b0:418:3b13:d810 with SMTP id e9e14a558f8ab-42f87369997mr124814435ab.9.1760118619250;
        Fri, 10 Oct 2025 10:50:19 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e2594a558sm117662939f.7.2025.10.10.10.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 10:50:18 -0700 (PDT)
Message-ID: <c60f6d32159d02df6c2c98477d22705539909245.camel@redhat.com>
Subject: Re: [PATCH v1 1/5] tools/rtla: Add fatal() and replace error
 handling pattern
From: Crystal Wood <crwood@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>,
  John Kacur <jkacur@redhat.com>, Jan Stancek <jstancek@redhat.com>, Tiezhu
 Yang <yangtiezhu@loongson.cn>, 	linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 10 Oct 2025 12:50:17 -0500
In-Reply-To: <CADDUTFwFerzjRTPp1F+Rw+_U2DoomAxyDonXudCwh9gyXSn=nw@mail.gmail.com>
References: <20251008195905.333514-1-costa.shul@redhat.com>
	 <20251008195905.333514-2-costa.shul@redhat.com>
	 <34afd8ffbb1c889e91fa536cf60369a697d86575.camel@redhat.com>
	 <CADDUTFwFerzjRTPp1F+Rw+_U2DoomAxyDonXudCwh9gyXSn=nw@mail.gmail.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xfjsUCc4kSkEW6lQf0UQ2EYJrK8sWP7awB_LR8dngOc_1760118620
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-10-10 at 10:20 +0300, Costa Shulyupin wrote:
> On Thu, 9 Oct 2025 at 00:55, Crystal Wood <crwood@redhat.com> wrote:
> > Looks like there was existing inconsistency with newlines... maybe have
> > fatal() include the newline automatically to simplify callers slightly?
> > We're not going to print a continuation if we're exiting.
> >=20
> > Otherwise, for the whole series:
> > Reviewed-by: Crystal Wood <crwood@redhat.com>
>=20
> fatal() belongs to the same family as debug_msg() and err_msg().
> Historically, the prototype and usage of these functions is identical
> to printf().
> printk() was identical as well, but now it adds a missing end-of-line
> automatically.
> fatal(), along with debug_msg() and err_msg(),
> can be upgraded too, but they should be updated together for consistency.

Only fatal() has the "you're never going to get a chance to print a
continuation line so why would you ever not want a newline?" aspect.

And this would be consistent with panic() on the kernel side.

-Crystal

