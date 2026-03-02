Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A7B3F0749
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 19:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772479547; cv=none; b=iNxBixeG1rorPg0Myq5gXr+m/TfZF+xu7+eFl6OV/bJriZ597ioSTKKDv6edqbqJiQfz5B9MbGcAQ6eM0zsQnmf0nf5/0wZTLrn6JN+KiJPDRC3l5JplG2MSx3ZJwrKSl41dEtTnjxEJDZNtUGdLG1p1EKDlDMmns/XhD/6atiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772479547; c=relaxed/simple;
	bh=J+AUgqG2xB7p0sKYPoHbxW6oqiPof/phY6bFlgGx9HQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kUwvjN85OgubRjiBUXOGw4WQ7UdedDwRscMwkT8lzvGMHCrQu+oVhPi7FBnr4Fb1d4tb6gYHv+S2iDwUpsDUNoJtgCQycIwKndPMtijD9g6SdpgBiC+R37ubfGIGn80qCp/BfYjzHG2wpw4Xpu9oGzy52IfpbH1TYBsOI6Nb2Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Jou00DTl; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Jou00DTl"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65f767a8d62so8534569a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 11:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772479541; x=1773084341; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=J+AUgqG2xB7p0sKYPoHbxW6oqiPof/phY6bFlgGx9HQ=;
        b=Jou00DTlV1wLf0s4P+EguDlXj6dUcr87XTAPjrfaUCeBzWAgXqJHc9UtRukwpMub7V
         bq/+HKiC5rv5z5eN94CNObbEu4DYJ+yqQo5E6dzrJPRGZ1Hs/M6VOjONnpR7rhwY31cR
         iP5UajxX1GmZpxa4QVpQ6XSc2gOWUKb970yTJh2pvC3ZujvEee0PSXrHN+V4yufaHsKi
         ysJiyJqnHeuO8g8wT9TJ2L/7wJiVsaCCO8MxuimJMCACqJs9faMHF71IAyO8AYUlaMZH
         ZRfo7zBh6LYOFnOed0gDypMeUTUgOnLYvq2QGgLOyWlgXE4Euk1sace4slt6VZ1O3EaL
         mUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772479541; x=1773084341;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+AUgqG2xB7p0sKYPoHbxW6oqiPof/phY6bFlgGx9HQ=;
        b=NYGXkaxY2FALKIC3sxayUMTRqQNbt4fCu/LsRwPo3YbBmkeLEji/T7iM2KumHBkm9m
         jaRfxjR4ONCoLz1borA8A1+EuyRcfDhxjslCl2mxxXGn7rdsCjUohYLMkGdjRjZJUwDP
         SceusfSyXZ2HVzlijzfgzokRRS4z1zuh7EFzxZlqbaKXe/ZA2Mj41winxdLkS1M9OR9e
         +vTHHvHsZzkJhUJSLtEPtP5ukW1R6CjYbVwM4RMEtP9HsuZ3HJ7Hk17PnhgwZIqQ+R2s
         8M5ggZgU27kWySdG3sO+wFSWF1EdD3uFac0dBeht8HMmfNHp8zGZVB/Xjbm6WLOSDHDC
         roUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+/AeIy3P+qmjcvj0AM5buOknfNXzyW2slX7nTsfS8dMcFJQKecku49Jn8ojRy4EtwiBPPdyYecOOqY3rrRyidjUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAS/68RC9bwwLiurxdhLOJqUYZD2+IErCX8P+zfIkB6w7TsCXK
	6zaWRbi6pilsCxV9W+bVsMP6eZuH6+o3tRW9sFfVjajx9URis/lns70EJHyCDwq8SrM=
X-Gm-Gg: ATEYQzx1cVTM34/gELWpF8J6dJH4VTNeKkGfrtbyJBx/3g5IndM6Gy4mtiQZ9nneOvm
	qemnZkPAmC5H8xFqQIFfylehPmuvgUcduqCN3iEWrP8CXnpgU54EDs1yS0+LQLUxDAXZaOLUMdo
	Q/A7eUwaEQ4lR9lGxwwV1zbbxL2Hiet5HcVV0Wy9noRl9Il63Xs5X82ccJGfE/mQCAlEBRbeSiS
	PNDQ39tRrGJ49z+6XllAUhovgGIweoU9GDlwtBMINCbhBbIl5VDVzaYabwLG3doVB10rFyw24tU
	Pcj7GLahJ0GCJM3vfKEpPJzwXFOGwGi8xAqhBC4ey61/zLMy0td1ime9m3ZQABjjYs04x1NAZjB
	rl6Q0N6sRaI8ADMFDPU2NW3C4T8kAsO8s+a97Qj8NAn46c7bC4GJXzQXNhp+Twyq8hdQTl1L3L0
	NQRewmYnZ1fpSSAR8cVK9qmJB1pm8=
X-Received: by 2002:a17:907:7b8e:b0:b8d:bf4d:7464 with SMTP id a640c23a62f3a-b937650c1e7mr881773166b.39.1772479541241;
        Mon, 02 Mar 2026 11:25:41 -0800 (PST)
Received: from cloudflare.com ([104.28.193.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ab137a1sm505344566b.2.2026.03.02.11.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 11:25:40 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,  bpf
 <bpf@vger.kernel.org>,  DL Linux Open Source Team
 <linux-open-source@crowdstrike.com>,  Alexei Starovoitov <ast@kernel.org>,
  Daniel Borkmann <daniel@iogearbox.net>,  Andrii Nakryiko
 <andrii@kernel.org>,  Jiri Olsa <jolsa@kernel.org>,  Steven Rostedt
 <rostedt@goodmis.org>,  linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [External] Re: [RFC PATCH bpf-next v3 0/3] Optimize
 kprobe.session attachment for exact function names
In-Reply-To: <CAOu3gNhBcW-JQ_VQ00GnLd8iB6xu7Ew80Bs4VHoXOct5g-wr4g@mail.gmail.com>
	(Andrey Grodzovsky's message of "Fri, 27 Feb 2026 16:15:07 -0500")
References: <20260227204052.725813-1-andrey.grodzovsky@crowdstrike.com>
	<CAADnVQLrhkCkpE6UZbkPaNTFMYRoa_ZtyknhVM7FMmsH7Lvj5A@mail.gmail.com>
	<CAOu3gNhBcW-JQ_VQ00GnLd8iB6xu7Ew80Bs4VHoXOct5g-wr4g@mail.gmail.com>
Date: Mon, 02 Mar 2026 20:25:39 +0100
Message-ID: <87fr6idoek.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 27, 2026 at 04:15 PM -05, Andrey Grodzovsky wrote:
> Hey Alexei, just to be clear, do you mean drop the entire RFC letter or,
> Drop the RFC prefix from the letter so the CI pipeline can be properly
> triggered ?

The prefix, not the cover letter.

Although I think swapping the word order might also work ("PATCH RFC").
I've seen CI run for my patch set when it was titled like that.

Kind reminder to not top-post :-)
