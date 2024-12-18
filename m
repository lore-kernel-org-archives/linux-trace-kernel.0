Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B108219CC17;
	Wed, 18 Dec 2024 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734528222; cv=none; b=rHc9SmVAK4PoGLkX/7tUQKEBB2uKzTfrbQQoHjYMZhayqZ8l/oRClB/VXUDbdvWo41ihp0nHjJYRjtwPXYPyC9Dr1165edNLq1/cG/952nnskRuqdfqhevXa8Pg+XsdVStWYHRXZdXvoAYxZ2mBBVR1gjVqxey2ur/VQYUX+fcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734528222; c=relaxed/simple;
	bh=5afv2XqzWhd0ZmoSGSXYsTBjch9PCJh4gwkmDITdj/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VHNH4U1uy0iqGIArrDs+ZUIxWTF32XDniTS2bBAnh8O1qVU3hkl7eXIjc6JWspwaNmv8p++XnuKblgpCsL8VcSqPjgNbno3Pf3HzrON+0KgzF5gM9YFV+7bwy3TV2mycTRkh4REnbxPPWbyGJPCfE2fRAc3QiN//YJ+iG2b1m9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FDEC4CECE;
	Wed, 18 Dec 2024 13:23:39 +0000 (UTC)
Date: Wed, 18 Dec 2024 08:24:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: vdonnefort@google.com, aha310510@gmail.com, david@redhat.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 syzbot+345e4443a21200874b18@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] ring-buffer: fix overflow in __rb_map_vma
Message-ID: <20241218082417.701399ad@gandalf.local.home>
In-Reply-To: <tencent_11A0A5D80DEC925EDDA2DDB8990F4FC88D07@qq.com>
References: <Z2KSR5QrAWYDEBVh@google.com>
	<tencent_11A0A5D80DEC925EDDA2DDB8990F4FC88D07@qq.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 19:42:22 +0800
Edward Adam Davis <eadavis@qq.com> wrote:

> Reported-by: syzbot+345e4443a21200874b18@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=345e4443a21200874b18
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
> V1 -> V2: updated according to Vincent Donnefort's suggestion, to avoid repeating the (nr_subbufs + 1) << subbuf_order
> 
>  kernel/trace/ring_buffer.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)


Also, when sending a new version of a patch, do not reply to the previous
version as that hides the new patch. It should start a new thread.
Otherwise it screws up tooling and also hides patches. I've missed patches
because they were replied to the previous patch. It makes it much harder on
the maintainer when someone does that.

What I usually do to maintain a history chain is have:

Signed-off-by: ...
---
Changes since v1: https://lore.kernel.org/all/tencent_E036A29600368E4A2075A7774D67023CFD09@qq.com/

- Updated according to Vincent Donnefort's suggestion, to avoid repeating
  the (nr_subbufs + 1) << subbuf_order


-- Steve
