Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C400713B792
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Nov 2024 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473432; cv=none; b=rQ5k3cAcYescYYLYuDOI2DUtlYkKYTkJ+mI0/rq7Tgtwr9FAB22k3l4aKTSwMQZ0rDrk9ecQmJif0mM0cc4Oy7bbQ0EkJpoxWYc5sdBRqY2yc1WTb39XCHptgbF3wHi1DDsWe530oOXUz+jXf4n9utcH7J3QzKrcxftDqExoCBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473432; c=relaxed/simple;
	bh=YX5sq6ZheiFtKApdJRRA0qJIqMgD+DQBat0h/g373yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jg+ZxtArpOPepJTmGH1QtQ5X/K/vAiKuaHdPLkG5ccwV16cEz4lVfQOTHEKEr4HN82z37qCzglsfKFCMTvneEyNanLEsheX1pfLDB1OSwm53xOcj2QKLIn4y88OtC6UmFv78z7ir87J7WFNpSuVrpb/Fay9XpPmfBhViwaLNVsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gykLoDI2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gykLoDI2"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c8ac50b79so95645ad.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 01 Nov 2024 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730473430; x=1731078230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YX5sq6ZheiFtKApdJRRA0qJIqMgD+DQBat0h/g373yk=;
        b=gykLoDI2DuEq5oSSJLE5frs0TT1DzrL9IFrqPAniiyuSw+ZykdIBnw/UHL4dx/GbrE
         hRE2UznsEjvBJ6SIEOyPdmy5xo+1hLNbMHmwLDmWxRjzIiKFhzy8IAeS79c2OoO05oC2
         fYm0ASM1GRpefBFIQHh0pQ0GWq8pLI6XHI26/1AQ44vT/auSOyz3Sz/DZwKgRGqB3Y5l
         08Ux/kwLyrE0DOcMHM3uf5yAi8SLl191LCURJs5Ndz4Y/yDKL+s6XSFjYi+9LePztRxL
         PA1zDeez8146vRU8UJBZ2B7C0U8HpZsF+BzIvnF3bHNdo0Ko2hadbXvpsZPoQXybjuZX
         8d4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730473430; x=1731078230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YX5sq6ZheiFtKApdJRRA0qJIqMgD+DQBat0h/g373yk=;
        b=M5e2YF5gTCkwSpI9Bq7DmclBeXP3I2J93ZfFN2cAVHa/GUoG/FwRSOqhrYJE0o7fKq
         5wPV63tuRTorSpbC7UXaBYhiQOHyLk3mDRPdTcTrKltBPYmz/nsebJBnlZ6sLccX8y6g
         5MDYes+wG4sILR8fNLv84QfGTO5r+x50Xzj+igaeGBVHfqs21YYe2GUpyft+HsgdsprA
         ldEXpNnx0egZq36kroDfHgK65Y3vszn8Goj1zz6396dGxc2QHOMs0RRzoq5F1w8WApj2
         iJe7HZBHo5/0hVgykqyGp1tbKSklf95ZoEPD7XOvjdiPd75uVB8kLaker5Wc0wkuODs3
         UZSQ==
X-Gm-Message-State: AOJu0YxbkpVIiey7NIsBt6/TkckSppd8cDlwad1Mo2xTsIgc6Z0SiWfJ
	9yF90d6vPBTmQRGyS0P6s7WTpaXBd/VjhqE/UX37wrFYIpA7ztOpTrQSsp23lYi97YONLWdKxan
	rZzgQSu2OxaiKTbwEsphRUaDeXXOzqQYX5YJ3
X-Gm-Gg: ASbGncs+zGf+inIh1MvIcYbfxCrhcP2glaZl2vBEdJSuHsOcMX81GVEs9TbGQeV9Bv8
	FklRxATkUJTaXlkQrcWgwGtKqVCuUGsA=
X-Google-Smtp-Source: AGHT+IHO6aa1H4NDIW0E9d+zicp8WZuquwRCLAb+vHiEevpZxqwYPVoVFHQYByqn3yh/phUy4h+4QI3F3VXJog6wc7c=
X-Received: by 2002:a17:902:f684:b0:1f7:34e4:ebc1 with SMTP id
 d9443c01a7336-21105425eddmr4269565ad.5.1730473429797; Fri, 01 Nov 2024
 08:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031210938.1696639-1-andrii@kernel.org> <20241031210938.1696639-3-andrii@kernel.org>
In-Reply-To: <20241031210938.1696639-3-andrii@kernel.org>
From: Jordan Rife <jrife@google.com>
Date: Fri, 1 Nov 2024 08:03:38 -0700
Message-ID: <CADKFtnSvogoT0ArYUqUFaBVUoQN4tfX6i_OdHNc4h2kaYvpZcQ@mail.gmail.com>
Subject: Re: [PATCH trace/for-next 3/3] bpf: ensure RCU Tasks Trace GP for
 sleepable raw tracepoint BPF links
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	rostedt@goodmis.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, mhiramat@kernel.org, peterz@infradead.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"

Just to confirm, I ran the reproducer from [1] after combining this
series with Mathieu's from [2] and it ran for 20m with no issues.

[1]: https://lore.kernel.org/bpf/67121037.050a0220.10f4f4.000f.GAE@google.com/
[2]: https://lore.kernel.org/bpf/20241031152056.744137-1-mathieu.desnoyers@efficios.com/T/#u

Tested-by: Jordan Rife <jrife@google.com>
