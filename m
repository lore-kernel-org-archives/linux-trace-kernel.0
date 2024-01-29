Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAA0157E61
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550973; cv=none; b=tCqkpU1nPcInk7hv61qtBXit4nOglOTELkYleJ1HbnoLK+LheQd91ELqGymBQklMsEzzd9fxJHj0v5eqYFhgdAAq5DH42HyHOFxEwSOEfL1MMfSJ/e9nOZhlHuXxbYXzYfaxQF9IbVG5kUOR3gxeQWVHB3nInt8662vaQS8ynvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550973; c=relaxed/simple;
	bh=eJ4tB/dpOgHGrxgqDYW104LSCUa8aT6Nh1QEcB2/LFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEnEjrCJkCFDI9UchLuhycGOge4YQw5KTT97B7CSH9ZiVO0QwfWN4rKl40bqhAyCQdKkg6qiiHL5Es/orTGA5Mf/TPiCuObcEUpwB93/htKXiQj0jKi59qOnMFoRP1ZkNu3dNPA0ODEjbzjrBHiLdd7XUmOi9NnxTsJCtsNX/Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=heAvSSTb; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="heAvSSTb"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55f12332350so1281232a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706550970; x=1707155770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AkYokCIwpJBz8xiFXNezYEF1FGA6YIGCtwREDWysAIE=;
        b=heAvSSTb75W6Y3CJNKb21/ZtCHt/Bm7spFnt9UT+MeoMP0WaU8+xVdeLjW1Gsip9o/
         j08cG/kTqWr1Mm/650KDN/juOcNmXP5Sv3YuoMvLhEeqMdv2NQAGtIAou7xuFv1bbZKZ
         uGxL75ttWmr7nvcAAtLH5Rm1dJy4yF3dVYBOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550970; x=1707155770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkYokCIwpJBz8xiFXNezYEF1FGA6YIGCtwREDWysAIE=;
        b=q0cdD4SWxYjdxHn7uIMhpdr1q1myFCWNHfNGH6B13vxo9tiVxZyuIXE0bYo2zvjcKD
         rQaKr7ZRNKBbDwYnJcc4GjHYmVmbeBPOgZPOdvOPTGVpctopsLPCqCLQAi+v79n3lDQj
         hLS8HDytRylk3U/peFZ0aIkHRMMb7i7QWUAVW3GUWwue7lDOr5qdsx2WKeOs+yNvIi05
         5fiw8/2eBqPM+FBT+eT2idW5EZlTvpA1+AlkhTTtRs+5QN1L/ZlGjvi9GjkIXTHsxOm0
         3/flq8hqnNXm9Nu3plGrhB7QH7lJo8XKzi1vFgHuF3FoLfnDNzIXmFp/W1P+bZ2EYopT
         N8qg==
X-Gm-Message-State: AOJu0YxPqUVRi8xybUiKvlljMvU+GWRI0ylLaUoInn7wu/+FWFgkwYJ0
	EnhClK3y9nIB3L0EI/CdSpcBH9cHmdnq0QlMfXDa6owXXjLmGSTb4hdLgR5VUxoMsGI0UoLlyTl
	vns8=
X-Google-Smtp-Source: AGHT+IGFk25BTODqN3ks0dRTo2yDwZlDEi2ivpKAVGp/NRJUMSs1a/wLyFUGsAhL0GBVlJAJnS7+7A==
X-Received: by 2002:a17:906:410b:b0:a35:e366:689a with SMTP id j11-20020a170906410b00b00a35e366689amr1518785ejk.19.1706550969790;
        Mon, 29 Jan 2024 09:56:09 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id kb4-20020a1709070f8400b00a3493e2dbfesm4130726ejc.53.2024.01.29.09.56.09
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 09:56:09 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55ee9805da7so1887500a12.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:56:09 -0800 (PST)
X-Received: by 2002:a05:6402:2709:b0:55a:392:143e with SMTP id
 y9-20020a056402270900b0055a0392143emr4968057edd.27.1706550969019; Mon, 29 Jan
 2024 09:56:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401291043.e62e89dc-oliver.sang@intel.com> <CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
 <20240129120125.605e97af@gandalf.local.home> <CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
In-Reply-To: <CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jan 2024 09:55:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgrTm3_Ro7_0WAsk0CW41g4pg1z7reZh4A0xCeMBUJtpQ@mail.gmail.com>
Message-ID: <CAHk-=wgrTm3_Ro7_0WAsk0CW41g4pg1z7reZh4A0xCeMBUJtpQ@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 09:40, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> eventfs_create_events_dir() seems to have the same bug with ti->flags,
> btw, but got the ti->private initialization right.
>
> Funnily enough, create_file() got this right. I don't even understand
> why create_dir() did what it did.
>
> IOW, I think the right fix is really just this:

Actually, I think you have another uninitialized field here too:
'dentry->d_fsdata'.

And it looks like both create_file and create_dir got that wrong, but
eventfs_create_events_dir() got it right.

So you *also* need to do that

        dentry->d_fsdata = ei;

before you do the d_instantiate().

Now, from a quick look, all the d_fsdata accesses *do* seem to be
protected by the eventfs_mutex, except

 (a) eventfs_create_events_dir() doesn't seem to take the mutex, but
gets the ordering right, so is ok

 (b) create_dir_dentry() drops the mutex in the middle, so the mutex
doesn't actually serialize anything

Not dropping the mutex in create_dir_dentry() *will* fix this bug, but
honestly, I'd suggest that in addition to not dropping the mutex, you
just fix the ordering too.

IOW, just do that

        dentry->d_fsdata = ei;

before you do d_instantiate(), and now accessing d_fsdata is just
always safe and doesn't even need the mutex.

The whole "initialize everything before exposing it to others" is
simply just a good idea.

                Linus
