Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823093E0226
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Apr 2026 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775083570; cv=pass; b=NApru8hB1IsWwZ7+QKtrmwKuWMxjxQ5YH8T/KHcWWLe3dd2qfi+jAfydSFsi9nabFaaDzBm5wk3q2C6XXPGcH9fFsPRGynWq84ZkLyIKNkjO9ozf8AfJ7G9rFAXdU/rV+Z04xboL/paHmcdUAHZf9F3p3Jzbv0ICUgV5/Y+12G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775083570; c=relaxed/simple;
	bh=yoKsBPpPhR+NlzJdW07NGJsybBN0qe9g8BjIvDfIdh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8aBusB4M8dEnMPSlxM31Oap5VknHcKZCsG+K6nlw8NyPvVuT3CUeJNgpEjr2cBFPvXN9tO70YRjYzRKAUrWw8WMtIgiuVVidyXTqJED7J09BiothZK6PwDoIZO8D8PYhZPK0GjTdv47jB3HxPRCWtCumZF2cFevBd5A3SLPC6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6/4VhU5; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6/4VhU5"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43d17bb1c1dso243281f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Apr 2026 15:46:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775083559; cv=none;
        d=google.com; s=arc-20240605;
        b=Pd+6oupeQsn+tA6ket3V9ebIg7SjxmPjGqSRIccanNu+OupfXYfJRTLJZ3PvP8egpH
         eciz3A7FoYHGFDCzMLCq+Ut1z24Sx7X55+rCd6/Vsd95yLZEJsUrNndCm51nCM8Sushe
         0sYJhskJD4qSKEiWM6Ri/7rNLcy2LXTJw9DQq7I10oSQejbAgMd0HnbLm80E2+5Y1Ysn
         zZ2DTqra+JaqmkLgS3eDohVZB5gcdhOjrKGqMxoeMZtDb6Kb0Im1l0GtMt8+CqR6XTH/
         hMq51FXm8jQj5oP+7vF1S195EeFeM0bk5St4EstOmh7yHAZxuk3Gh3AKNsJYB+ltMbgl
         rMdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ADfyEQKl3tpwiQcUBN/SGYqRNQVzR4cZLBHrcXxZk0Y=;
        fh=hVTZzsZ8EpbFKrV5ARni0kLMmfGpcofhBNTjWWT2pAs=;
        b=VMGD8ZyKD9ZeLuiL7GhTTr0fiQ0oIpbVu9m9S7IjDgTsRds4500JsYmpROyANaxzhm
         E2LBTuvjwrrgYnn+Nr5iAUzvA8aWq8p8rH3w4JqxFCEyQIcm8FGlaUESmm+5SlreoVLy
         3ObS13WvDfL/JmdFlGHqi06ox9v/69Q8yqBGhWo4QFA1o5SyN2UQkvaEdWmzmLm0o4X9
         naldV0NhMxo+5fwcxoi6V8CD3oT1R8lRVPEfCLKGV8JfZG9TGYHWngyCBrmEBcKkkUk/
         wlVr2qI0WJzNr3mCvXvvxXvYkX9wTVwch+W8a1I129k16LEXTVNzhjFkDX3svFS3g2zd
         0Iyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775083559; x=1775688359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ADfyEQKl3tpwiQcUBN/SGYqRNQVzR4cZLBHrcXxZk0Y=;
        b=C6/4VhU5G3hReiBiVGlVp0308KZ4tpOTAssO5g+Y9IhhE7Z+vsyyhInVia1AsghBFl
         BaMI5wRTny+f/c4e68/FBSlqGH4XGwF+ra2YNOgo7y2sfVbgtAs+FyXHIFmXBGxYizbg
         QJsrwsI4WJLFK7KyAly6hGHjVQvbyXlCLlHNW0KLTFALxGkiqwK1U151AR0zIi6k1vjk
         f5F8fX3epeeqqie3rcfaDaHXpdL1W2Iqxhx5DflBcfIcalYk2/k52lMpb3olVnnNzxM1
         jukcmVq0c5WcfA0/Gd93OIc0uzqf2G2wQTvmrPz3GSsNBm9W0amuZ6dNVBhmPSmZjsIJ
         GW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775083559; x=1775688359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADfyEQKl3tpwiQcUBN/SGYqRNQVzR4cZLBHrcXxZk0Y=;
        b=CPRp0DNTLXr/fi6v2jFTLFy9FJlY/lyZFQQc3h/C+6aQJBuZ6guio8iGBdRU60bUUA
         1VFkp1aHRb4mqpw3aB/0HqhriLMdZ9yz+xcFAuTde5sbblxApRvAlCvb4GLnqGrttEE7
         YIpqwYtANa7S1zuWSQBdN3YJ9hY80f0DOJ7z9Ekp+sW9ABy1WaeLCQfdcCIzGmpTe+dj
         oOSAmYnGZeNc2PcJSe0vI4l3yAJdypGzcUEBFvbBW87XiojBVqgPqFRrDoMgYD1qkk6q
         PLnjpZbtTsvilunvAerijCB3pbRKEHbF3ojj+PCdzT6Oy237Ebz/Vj6cUj1CoywVWoxH
         0OxA==
X-Forwarded-Encrypted: i=1; AJvYcCWz1asp5R664hQCo7iNFzsDniYEJgQnsoON0neNeFM2PwkOON0hvV7uecXiZdTO8lgKhIBfTV6XPvrEtYIhPSslvJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8NffVv4jGUWQVXjnQAlVgvnLErp6W8duHXHc5EGH8V75V7/NI
	r8AZJGoVrJ0ZGOq8URixZnKI0G4K90Lm+6EqEMZEhU1a4mFebPs14o3kfsN3vYNb6AfMGqupmqW
	H61LSwKIhIuEDoJiDxA+uzTHEyoGmecM=
X-Gm-Gg: ATEYQzxTXu8za7EF+WeQIS0vQ0XRjAjSFU9OPXV62zq4DwUZOug2s7R1C/OGoupiyg3
	wcM+45/HGvEpeVZHpyFYeZvpQA8Mb8WQAPQrfW2sABF2EVhBziMhE+TyMXJv2iyLQ+29ufl4pey
	k4F4iCIWOLafaDC8kHdMPbunHlwXnpV3/pJv6D6G+tEHelGgKr7Vc/mHMxr97xFMveEk8zs8OAT
	Dw1Iyh4bbT3l4g5JpGc04QHg4/WHOLeThEr3Gz/kvzkPbFag90fsTwK4G+HeN626uhE4qZXSzow
	5D5gFGjv/aUKHb0TkQtLOMwonlv3+XnHxOHcZBQ9fpf9+RAaEIY4/wmZ6Lkcml8aB3LBxA==
X-Received: by 2002:a05:6000:4009:b0:439:c18f:5aaf with SMTP id
 ffacd0b85a97d-43d1f25aa0dmr1879240f8f.34.1775083558432; Wed, 01 Apr 2026
 15:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401191126.440683-1-varunrmallya@gmail.com>
In-Reply-To: <20260401191126.440683-1-varunrmallya@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 2 Apr 2026 00:45:22 +0200
X-Gm-Features: AQROBzAz8G6KDlX_EpiUXFkOb-GbK8pH-ZY0h5VhNGUNmRhQFstxQ8m8i5dLXD4
Message-ID: <CAP01T77q=ZRTbA03qVb5pdkYg6FJujLts_qa+t9FX46bDecxfQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: Reject sleepable kprobe_multi programs at
 attach time
To: Varun R Mallya <varunrmallya@gmail.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	yonghong.song@linux.dev, rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Apr 2026 at 21:11, Varun R Mallya <varunrmallya@gmail.com> wrote:
>
> kprobe.multi programs run in atomic/RCU context and cannot sleep.
> However, bpf_kprobe_multi_link_attach() did not validate whether the
> program being attached had the sleepable flag set, allowing sleepable
> helpers such as bpf_copy_from_user() to be invoked from a non-sleepable
> context.
>
> This causes a "sleeping function called from invalid context" splat:
>
>   BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:169
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1787, name: sudo
>   preempt_count: 1, expected: 0
>   RCU nest depth: 2, expected: 0
>
> Fix this by rejecting sleepable programs early in
> bpf_kprobe_multi_link_attach(), before any further processing.
>
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Jiri, would be great if you can ack both patches too.
