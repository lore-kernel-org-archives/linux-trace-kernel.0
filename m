Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374474A32;
	Thu,  6 Aug 2026 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023691; cv=none; b=Vku1R8af4lBGm1MqG3L7rqATeJz4Kw2rK7VzrzP2Wsby740XMi/q/1dP/5SxtXQW+PLX+9+gcAgsUikEdvBwtHeOvxCkc0ELh1QvyyNCuzniQhfiihoC6foD2OaVkOMZNPvkHIA7/DIRUZdxAwfv4h7Ts+2VTM9rC1BqyqCwlz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023691; c=relaxed/simple;
	bh=vKwmvMQ3K/xckpG0mZgEBf79C8grhiemZP7bBkbDmLA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nmdk8m5uYHL+rJP8pevWYq8vlB55tyZMQbyfjQv2yJlMi6A5T1jU4XtTOlA2HUjsuuCngxnQNCSgEzocTn76RlLRxsjZ1rE6Z3yoKAARCJfwNKcmOC4IpudIWnz/vWRsiT5941FXvmJ6tHdc+kSj05UexKx3Gevw9VcEHHPkMfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqPqoInk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqPqoInk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192F11F000E9;
	Thu,  6 Aug 2026 13:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786023689;
	bh=Ru6IPOsdzDitRU6k/P9dLvDIcUp6eZjujRM3axRZpGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GqPqoInklXR36s3aFWIeh8vu0mUyTXHZ20MxRidbesHpWU2j+OkJQHHtBfP81A8DE
	 IvMwh9nHvRv7CPN4NDkfKXDeDulcrob2V8PS2ICtBuqfq0K/tPlwuKRiV9wXtiWP6c
	 RwCEQaxIkVX3/jo4I2u6Q6A1Ivm231BBnQyon6DyRtKj0ShFTIc61f3doUYgjpkPR/
	 6QDu+Di/RbRZSEQ0J3YnpIqXaikj6VMrCYXsJTDLyO+dalKkkmvcs9LIgpBXPzQsRK
	 nd3+nuoI7TSCc+D9bJ2iRR5xfk18/AvKTKOU0qCkKsQ7iODApKVbjhdb+X4Wc+BXVi
	 b/TUVxTP//Qkg==
Date: Thu, 6 Aug 2026 22:41:25 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Luigi Rizzo <lrizzo@google.com>
Cc: Naveen N Rao <naveen@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, JP Kobryn
 <inwardvessel@gmail.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Fix NULL pointer dereference in
 unregister_kretprobes()
Message-Id: <20260806224125.6c1048fed96cac11bfb31233@kernel.org>
In-Reply-To: <CAMOZA0+4dE0N3J35pTVTBgvFzP2a-b47Z_LZYwKNwej5jUx0zg@mail.gmail.com>
References: <20260805161221.2428623-1-lrizzo@google.com>
	<20260806090235.e40c75f84f8a01b9a80fd570@kernel.org>
	<CAMOZA0+4dE0N3J35pTVTBgvFzP2a-b47Z_LZYwKNwej5jUx0zg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 6 Aug 2026 09:23:29 +0200
Luigi Rizzo <lrizzo@google.com> wrote:

> On Thu, Aug 6, 2026 at 2:02 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Wed,  5 Aug 2026 16:12:21 +0000
> > Luigi Rizzo <lrizzo@google.com> wrote:
> >
> > > In unregister_kretprobes(), rps[i]->rph can be NULL e.g. when called
> > > after kretprobe failed registration. Under !CONFIG_KRETPROBE_ON_RETHOOK,
> > > the unconditional access to rps[i]->rph->rp, causes a kernel panic due
> > > to NULL pointer dereference.
> >
> > This is not a bug, since if register_kretprobe(rp) fails, rp must NOT be
> > passed to unregister_kretprobe(rp). Or, do you find any cases where
> > register_kretprobe() fails, preventing proper cleanup, and requiring
> > unregister_kretprobe()? If so, we have to fix that case.
> 
> Masami, you are right, the kernel tree does not call unregister_kretprobes()
> on a failed registration. I was confused by the unregister_kretprobes(rps, i);
> call in the cleanup in register_kretprobes(), but the failed entry i is
> not unregistered).

Yes, in that case rps[i] is not unregistered ;)

> 
> So aside from protective coding (but where would one stop ?
> null rps, null rps[i], ... ), there is no need for this patch.

OK, Thanks for the confirmation!

Thanks,


> 
> thanks for the feedback
> Luigi


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
