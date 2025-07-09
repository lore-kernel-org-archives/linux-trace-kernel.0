Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39518137932;
	Wed,  9 Jul 2025 01:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752023189; cv=none; b=MDqBBtdKziLBVbndZxkv1Zm7TnTutE8MvszIR4ylNZbm4lZ5VyKS3doMuobNR/ZsXCtMsikzqy0G2rvWp8CUg+Ijp1Ux//7mKrtjhK4cczCp1gD/wJyk+fBBkgecjuNXgwOSRRVFSeYaWEZ90eCjSmxfn6wjotv8j44TtlONdC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752023189; c=relaxed/simple;
	bh=+uzmlFz8iYlo60nhP0pzuMSC2bp0z52jdCRIXrQFpm0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pzBfhzMYZIiSDWjmpbIAGHyxhi+g54ZuJe202wYT+X4zj23NQR0Z3NQl5OcCs4p/sS3Mq1SPfImC06dXjsv1+3TFqhBxulduXHsKyJ13Mg3TexAbU+hQ0xdgeWL2VDTHX9EJ0ADDqPZAkd/rdhTl+Tgz7JK2jQOq9paNbEkVez8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7Nl3BiI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7Nl3BiI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85B2C4CEED;
	Wed,  9 Jul 2025 01:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752023188;
	bh=+uzmlFz8iYlo60nhP0pzuMSC2bp0z52jdCRIXrQFpm0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n7Nl3BiI7UM5xACeiBG5qdew3FdOpoPUYl1wHLjP6ubzqnXelREIpy34gacTY34rE
	 bY7tCo1lw306SSVV4H2RmpnLS1OaGLQlN3ttROLIaNzqsuUYNg1DxPNC3B2oGMZSIX
	 YoFVV1ocT9bcUNjrye9eooJP4DoO6mMKktZMInz70DBu9GsvOftzRM/lgZfSZxoRkC
	 seJkfo5mpTsOGIm51iZRtHHv9u7RcFqlpJQA1Isy4imx2j7XZntEpcmeAciafuTyIg
	 JZyegeVMIXI+El4eYYlj/RO2L/fQ6BViivtdKd+0fmf4NI03M6KJUqMeGFqfvMD38X
	 GP4Dk25hFtARA==
Date: Wed, 9 Jul 2025 10:06:26 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriele Paoloni <gpaoloni@redhat.com>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RESEND] tracing: add kernel documentation for
 trace_array_set_clr_event, trace_set_clr_event and supporting functions
Message-Id: <20250709100626.fc0611eb6801b7a8dad9164f@kernel.org>
In-Reply-To: <20250701195939.3e297e20@gandalf.local.home>
References: <20250620085618.4489-1-gpaoloni@redhat.com>
	<20250701195939.3e297e20@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Jul 2025 19:59:39 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > + * __ftrace_event_enable_disable - enable or disable a trace event
> > + * @file: trace event file associated with the event.
> > + * @enable: 0 or 1 respectively to disable/enable the event (any other value is
> > + * invalid).
> 
> Saying 0 or 1 should assume that those are the only values. Don't need the
> content in the parenthesis.

BTW, it should be "0 or !0"? (or we should make it boolean)
This description means if it is "2", that is undefined.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
