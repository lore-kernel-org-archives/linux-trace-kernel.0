Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45144314B63;
	Mon,  1 Jun 2026 04:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780288310; cv=none; b=pHoMWjhfyartAu5/VxT3+Ete+4ugqXYcOazRBMbO3zLX9OcMD+HJnFGx0KNVY/nVDbYJzSj3p5wvn8+8RXkbl46b4DU6VyAD2bwfFE3d1ccT761VKV2KPCOQm7YG97BCNaTg+vo34WbXEOXqDwG+dP2jZYB+Qn88nFAkegEXYtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780288310; c=relaxed/simple;
	bh=s0BX45L0sWVIGDOh1RTHQxm2WUKeqKfvcWhCuik3r8k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=H5Swym48vb4eN6ocFH9XwDiQH+fs6rS/7kPAtfGBUdQQFkKekuRK+FhHrXXgZeIzjSsg4houc2CAKzjbgfd2o/Fp0xtbZrNvUDas4unxWzrC+QcvZa/aAU60sBc+X1C219xvqO8jxmmd1KpEPpVtj8sybF1PgkT2avCAbAjZAcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFDlc9XN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFDlc9XN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B436F1F00893;
	Mon,  1 Jun 2026 04:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780288309;
	bh=37qGQZaPw/dWTrWCnULlgc4kI4ji2bvU7/GpzFmiqGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nFDlc9XNgbBE6MxvyJy7sWjwPuT9XtQOr0hw2JL4Vg7uayD+8GQOjGIKULjamXWqP
	 f8GWgLdp7Wj8ZvI1DSYqqlxLpFzn3jPtjMCPwDex89xlUzWBGa/E73NDS3CP0bujCb
	 YO5/Zl1IUddJ3Pp7t9B5cYs3lvtCZH+mAGZ2kdyr4eIdqhPhLHj12GgLl4sGGV2X8q
	 o0ldlhjIFVytayeN0YwG6OuSM94p/P+XGWKx326tgxK4N/kCu/xeiKBY7etMzRtZul
	 Ed1R8SMs+Gj25jqCQNtdS9gles7OEfcD7ZU7HDqm23BX2mskjy/m8DqMsZ2eX7LUT2
	 nfpQeur5pffaw==
Date: Mon, 1 Jun 2026 13:31:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: CaoRuichuang <create0818@163.com>, Shuah Khan
 <skhan@linuxfoundation.org>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Drop invalid top-level local in
 test_ownership
Message-Id: <20260601133146.b16b0ad7c2204adcc168c945@kernel.org>
In-Reply-To: <20260407203727.442b583c@gandalf.local.home>
References: <20260407102613.81419-1-create0818@163.com>
	<20260407203727.442b583c@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Apr 2026 20:37:27 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Shuah,
> 
> Care to take this through your tree. Probably could even add:
> 
> Cc: stable@vger.kernel.org
> Fixes: 8b55572e51805 ("tracing/selftests: Add tracefs mount options test")
> 
> As well as:
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 

Shuah, here is my ack too.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

BTW, to avoid similar issue, 

Thanks, 

> -- Steve
> 
> 
> On Tue,  7 Apr 2026 18:26:13 +0800
> CaoRuichuang <create0818@163.com> wrote:
> 
> > From: Cao Ruichuang <create0818@163.com>
> > 
> > test_ownership.tc is sourced by ftracetest under /bin/sh.
> > 
> > The script currently declares mount_point with local at file scope,
> > which makes /bin/sh abort with "local: not in a function" before the
> > test can reach the eventfs ownership checks.
> > 
> > Replace the top-level local declaration with a normal shell variable so
> > kernels that support the gid= tracefs mount option can run the test at
> > all.
> > 
> > Signed-off-by: Cao Ruichuang <create0818@163.com>
> > ---
> >  tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> > index e71cc3ad0..6d00d3c0f 100644
> > --- a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> > @@ -6,7 +6,7 @@
> >  original_group=`stat -c "%g" .`
> >  original_owner=`stat -c "%u" .`
> >  
> > -local mount_point=$(get_mount_point)
> > +mount_point=$(get_mount_point)
> >  
> >  mount_options=$(get_mnt_options "$mount_point")
> >  
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
