Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE1518FDAB;
	Mon, 30 Sep 2024 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727705145; cv=none; b=ce8zbOB7vKEzy3Q60To5LSIG2lFqV4RaHu4eiIIoExCGrSZ+VFPfD3INdQL9FRvdBeXma4DoQPbPlTJs0OCjnf9QLI2AECZljZqbwOSHtdM5mIwDPbHWhOb+oWSRleB3RdhNoJ9ZghEEcSuIqO2qHgVSu40M34PhM2EoF714Vpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727705145; c=relaxed/simple;
	bh=gUJi+citqOcF0chQ1QSkOqV+A+ms+uqytlnu1RCrA1k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHp+UtP1tJ+LMVj6uJx8qtcMY64bvsCjmxbG2BcxVHrutHmiSIGO3hhVnvemose95Yx4C0TtGFKD3spduIlUTmCuqNUn5CcqiGyshWd+tbDZPu/ARAIDEQEvlWa921N8pg0B8ELMttnLoSW6EkUIP5cYlCpAUucQ8VV3C3JWmX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAD6C4CEC7;
	Mon, 30 Sep 2024 14:05:44 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:06:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Question about config UPROBES and UPROBE_EVENTS
Message-ID: <20240930100630.7894c442@gandalf.local.home>
In-Reply-To: <f639079e-bc1c-7f2a-4c3f-de1a6780da84@loongson.cn>
References: <1a3567d5-e558-351a-c45d-73b2e5a8788c@loongson.cn>
	<20240930081529.f6f9161c20db9b95c9b46252@kernel.org>
	<f639079e-bc1c-7f2a-4c3f-de1a6780da84@loongson.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 09:33:42 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> > the CONFIG_UPROBES is disabled by default and make CONFIG_UPROBE_EVENTS
> > depending on it, the uprobe_events menu is hidden. I don't like this.  
> 
> This is somehow like the current status of CONFIG_KPROBES and
> CONFIG_KPROBE_EVENTS.

The question is, can uprobes be used without uprobe_events? With the
current BPF work that I haven't been following, it may be possible now.

If uprobes can be used without uprobe events, like kprobes can be used
without kprobe events, then I can see having uprobes as a separate config
menu option. If not, then no, it shouldn't be.

-- Steve
