Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1963C56473
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832684; cv=none; b=BJyzPRT1S5xf/+ar/90SQvj3ZVKkxOXpyU+fUkwDyyNoxt6cOsS5w1w1PAaRCACta9PogdQouahChHNzl72PD7uIDJifTk7dehH7otb1uzH4pa1B8OHJYRwYwkCbmtpsoqTdglJJaUYRmCQ0u03T3ODp4adiupyS9ey1FaT5OeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832684; c=relaxed/simple;
	bh=PG0fnIj5fzPwDy7NKqOopv4gHng+od9OkxEHBqOwPyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkwYTALkAU31Wua9uoV7aVHwDe1Qaaricy3U+cspn5yNrSjWFCuPKCO/qe6INxc5VMoXMwROxf6XhKCFGVcd/r2aOp+JTufeiPazCAWUhQvZrUgyG1PCs7RNVnmKhahP0TIyhF/aLv2u2kvTgG3mD894agMfMfS3/SiZvdBeWOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D4+npAXG; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D4+npAXG"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56101dee221so8780a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707832681; x=1708437481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbE5lBYMsBbNOMJCkljKpvO5qoGNkQekNJoA2aNf4aY=;
        b=D4+npAXG9fobh5Fw5uc+fz6WEtBM0rQM8CeL+RRR+5mgqTvfAnOyMjXp5tZ1FHvx5k
         bWVQdrl9P4XU4U79BRYu4c9NB9YC9YAE4GUw+VW+XLv/FDtMUHc05ssfhjgA4iMKVh9t
         TMoQk/x4fcY96MGb5WUTd7dTFNl6nuYndBYbe9TF+8GlIi2sdHNemuKuOgnP6j8/+67T
         m2Oc+0pQBPDlBvXnbbBGjNfjkoh2xyHNNw4P20/UN7OrQch0AXLtZYfPKbeqjJibSUT8
         otH1yjEKEphuPaxpHbyHLeHnVxunZLmDvs2et/fDp19fm/R/QAfoVuj43Tw0fizjjm+9
         bFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707832681; x=1708437481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbE5lBYMsBbNOMJCkljKpvO5qoGNkQekNJoA2aNf4aY=;
        b=ra9OeV0jx5x1lBj4whp6u4EQgD+8gXjb58Zj3L9l0e85fZW44obY8AXqEvtpgI4uDm
         vpKcU9q6Nb0VNm6bFRzTq5UwcCM13SsoKv8uSYutn4oO/Xb5SLNDV7NX1o/rciFWH4W+
         d0AVOmDLnDE3S2HBM0cBJ7UqyqGOKaOxa3I7LzSOZBqFuPt0rle0FKUPdGJNfw6Xg0LH
         9NtPAjZcF4YR6qwvlVtFSH0ftlrbl7u+Werg3Vs1fXzuZ5gYAnMYwQ3K6Q0jopADDB5n
         NZKw4++Y1C/xBxVkj8v/rEIcHeHBcvHtO29grvrQPKlPl91wL5SOYnMHwW5nQf1+6PZW
         8vUA==
X-Forwarded-Encrypted: i=1; AJvYcCWcJwfgpsS/IXmiCdoyZqtK9BQ0QUP2NiulYRGvDVCCIoVW287JQFd6wtWYudUW9hIvv5rEpBuEqO41hsBAGbuJ0bFQtcWVihiItxiYXIvGoZ2Y
X-Gm-Message-State: AOJu0YxW0xN1PvBRIt/4Hkfts5BAf3d6gisFvsVjGfnUnLpfR/akiLdv
	mBf2nTS9wQ2l2acHMxdAYuc5Na5YeSUnegK9at4c2Qy/ySAI97SRy2UZmRztYrR2T8lm6yR9JD+
	Pik8iZ1lAZYvRFIotsKgxjR6z9C+GlLKcP8ww
X-Google-Smtp-Source: AGHT+IGfb6Z8v6hajoJG9DaoOpHtyuo/KUVPZbwc7KekimKgbqmQ3fGjlKpw8V/ld9ImDFucTk16eL40tenMPfDdd+Q=
X-Received: by 2002:a50:9b5e:0:b0:55f:8851:d03b with SMTP id
 a30-20020a509b5e000000b0055f8851d03bmr120225edj.5.1707832681004; Tue, 13 Feb
 2024 05:58:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202165315.2506384-1-leitao@debian.org>
In-Reply-To: <20240202165315.2506384-1-leitao@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 13 Feb 2024 14:57:49 +0100
Message-ID: <CANn89iLWWDjp71R7zttfTcEvZEdmcA1qo47oXkAX5DuciYvOtQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: dqs: add NIC stall detector based on BQL
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	weiwan@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	horms@kernel.org, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Johannes Berg <johannes.berg@intel.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 5:55=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> softnet_data->time_squeeze is sometimes used as a proxy for
> host overload or indication of scheduling problems. In practice
> this statistic is very noisy and has hard to grasp units -
> e.g. is 10 squeezes a second to be expected, or high?
>
> Delaying network (NAPI) processing leads to drops on NIC queues
> but also RTT bloat, impacting pacing and CA decisions.
> Stalls are a little hard to detect on the Rx side, because
> there may simply have not been any packets received in given
> period of time. Packet timestamps help a little bit, but
> again we don't know if packets are stale because we're
> not keeping up or because someone (*cough* cgroups)
> disabled IRQs for a long time.

Please note that adding other sysfs entries is expensive for workloads
creating/deleting netdev and netns often.

I _think_ we should find a way for not creating
/sys/class/net/<interface>/queues/tx-{Q}/byte_queue_limits  directory
and files
for non BQL enabled devices (like loopback !)
