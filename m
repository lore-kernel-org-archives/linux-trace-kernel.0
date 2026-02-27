Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D99943CED7;
	Fri, 27 Feb 2026 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204983; cv=none; b=JKM3zLt8sKu72wgKUMFXaI4pLh8BS0zvw4ZdPETTDOh0RrcyzT3Ue0Mb8d7NN3Z1o5LV+Fg3BGSy/nNtGNQAbmaqXSEu9u1xN/vAzzOv2F8C3a65NcBG4TjQBAckh711WkJhjGqAmjPcXY0l6HeMzLxNqGUdX0e5DpUmtUWf1iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204983; c=relaxed/simple;
	bh=FBlbP3EPFUp7PQ6k0kHFG6GMgYCzGba1rNGnfgUMbf0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DE0uWHlgr8Mz0HxWb4DKZE2yTlMriYcfAFjersSILVw0ojVeWN2qoG4clfgNW338ZbWyzFX2nYgEWql7IdhnOam0uH+lixJUny/Qa7T2w4QXym+2G4zNnbG98sDuKn2r+x2mMCpcpPZMjdDM8J+3Rnc1aT3fyXUy6ZIQ+RfRlq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id D06DAC2760;
	Fri, 27 Feb 2026 15:09:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id CA80618;
	Fri, 27 Feb 2026 15:09:37 +0000 (UTC)
Date: Fri, 27 Feb 2026 10:10:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Qing Wang <wangqing7171@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com
Subject: Re: [PATCH] tracing: Fix WARN_ON in tracing_buffers_mmap_close
Message-ID: <20260227101002.614add75@gandalf.local.home>
In-Reply-To: <aaF0zS3xh5KgM_yy@google.com>
References: <20260227025842.1085206-1-wangqing7171@gmail.com>
	<aaFrmHzIAkEe7ufy@google.com>
	<aaF0zS3xh5KgM_yy@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: CA80618
X-Stat-Signature: ofai8ftkh8g4cc86bty8mwqjxehijt6k
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/0Ix6c0vOFhFNA4D7m8qRMfxOF/hcS3Z0=
X-HE-Tag: 1772204977-4002
X-HE-Meta: U2FsdGVkX18sIeeHOEXg9oWK3WNtFoRx4xedh0dUTckl8R3N2ih8IwQktyit2tomI/4f9HF7kq+04rAPp2/wzOzJiU/dU0V6yPTygnDVYAu+iQXlSyLS/O4YA3bszu1Sy2b0a1cAxj5oSLKB0IcdQoDuu4SqXIRePyObXMpkqJy91d5HjamNKo0qYV4zZz0J+xPB8J+tyQzxGpWO3LX/JhfVHRwN96szv34UB7Ipg6svq1hacVVNqya79hxorT550EHgx5Hp0YEaYWZweqyM5ZfditGezhjFIybWghBcgK9qqyqxVTuXArouZxa8OKfsVyl6G24xC4/4AP2ptawRgX3oCVUT5ZNc

On Fri, 27 Feb 2026 10:41:17 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> > Hum, not sure this is entirely correct. We do set VM_DONTCOPY when creating the
> > mapping (see __rb_map_vma). So AFAICT ->open() is not called in this situation (see
> > dup_mmap())  
> 
> Ah right, Syzkaller is using madvise(MADVISE_DOFORK) which resets VM_DONTCOPY.

Hmm,

So this means user space can override the DONTCOPY? Can this cause bugs
elsewhere that DONTCOPY is used?

-- Steve
