Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A398719ABDE;
	Sat, 15 Feb 2025 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739633825; cv=none; b=j4ut4OQxSLZ0CzCpDGI1RoZpSQOLICja9oZtmxVkSVA44OuNx67AiaOOdI3qjWlM6Ijgniugm7t2o1Q8idoEPhWyWTRZ7uf/Q83uLM1rM4Sl7EdslJQhKlRqXud0QTQeSXBEFfeqAwyewXc18A/qr/e3xxw+Oe5m7grnOJWMTNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739633825; c=relaxed/simple;
	bh=qgv+eEVZ/QnPjxw+OPstNIcH0nqgtyxfQny/S6YCJtk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qH99oHVjNR36CY4M0BhkT0qxzF51ieWPIsuhdrjmFVfmQCZ9PpBpKC09aLQZnb0ZA6JVBL/eLx0Nfc0MbfkubgTmLwTOtL++Q6ZGByD7RLtAaaGi8Ydg0BRtcxITg7v/3hlvQ4dmQyvmuupSu/JxEZU5TAK5k3wWXg2spGefhvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ridc4nAL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ridc4nAL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C997AC4CEDF;
	Sat, 15 Feb 2025 15:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739633824;
	bh=qgv+eEVZ/QnPjxw+OPstNIcH0nqgtyxfQny/S6YCJtk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ridc4nALUjWrp5cBYzBAq/S6FbCz0TryGfM5G1WLruiZA4EMUdYLZJ+B42Ji0Cfqh
	 X7tEEMcPVUMBp5VHdzYIxiy33u19YLL6lPrybjXkR39Hd/9Fp9t3KcoOFzqSvSRoDF
	 h5ULtHij4F57ZX2+GmRJiIKjih4WyUd0JRQACQir2txsxu7mvi63kHQwv9rv0l8Ea6
	 2SL6tYnlxU/CmldIEumZSuqG0tZ+r2TkSezyMZqN8n/nekD80NWB85D/1+b8lvN0pS
	 wafMhE61PtHa/urVi5xf2/Xov0eUwiCHvEswxns6T33/b3B5QzToL72shju1Q6bEJw
	 ckcCdB5kSbx4w==
Date: Sun, 16 Feb 2025 00:37:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH] tracing: Do not allow mmap() of persistent ring buffer
Message-Id: <20250216003702.eef00d543ebbc3b16140ed9c@kernel.org>
In-Reply-To: <20250214095943.178501fa@gandalf.local.home>
References: <20250213180737.061871ae@gandalf.local.home>
	<20250214110722.7eaf35b42c4858e6b74500f7@kernel.org>
	<20250213212147.6511b235@gandalf.local.home>
	<20250214161332.8797b20f09e068c33f872698@kernel.org>
	<20250214070712.01997ea1@gandalf.local.home>
	<20250214233613.bde0638f393186f56f0b30eb@kernel.org>
	<20250214095943.178501fa@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 09:59:43 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 14 Feb 2025 23:36:13 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > 
> > > It's not supported. If you try it, it will crash. This prevents reading via
> > > mmap() on a boot buffer. I don't know what you are asking. Once this patch
> > > is applied, mmap() will always fail on the boot buffer before or after you
> > > start it.  
> > 
> > Hmm, I meant it is supported for other non-persisten ring buffer, isn't it?
> 
> Correct. It is supported in other buffers, but it just isn't supported in
> the persistent one.
> 
> This patch only disables mmap if it's trying to mmap a persistent one.
> 
> I guess I don't understand your concern.

My concern is related to the fixes policy. If this is a "fix", we will
backport the new "disables mmap on persistent ring buffer" limitation
to the stable kernel (that was not documented previously.)

However, from the user point of view, "mmap() ring buffers" is already
supported (although it did not work on stable kernel for now). Thus I think
the "Fix" is expected as "fixing mmap() persistent ring buffer". 

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
