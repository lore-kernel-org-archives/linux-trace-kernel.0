Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E845551E455;
	Tue, 13 Oct 2026 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902576; cv=none; b=cwr/iaVQnQn0d8oYWoyK3Lv4AMuNkzDk7mkoaFJQhblEuEtrKlooHIfDkzslDYYxMF8++K2HB+uieuO5jfSTPZ8pa2vAZijYT00UMJQXD3oelbZXfO8Dj2C9kfKTWPX99P2E7SKt+YJbeEY1do5R5ResAI3x5uEBluW6ncRhnYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902576; c=relaxed/simple;
	bh=/84FAew/yDd2HK0Zty8Isjb9ucdv8qvazeHYj90D91E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESX4/Dd7L7crOU2VrP/iS2xAyQ4iaKe3sX9q3TUnv5rVAfS9LDWKoLQc0hPUKssmaC3Oudz1ZspS06UH07VuAGGa9zOVhvXcZb38ICzu2px1AW9e+wESmoyVlWNqMHW6BDQgBFOQRSO3zNmNuA8JlVkJUUHhmWrJGIYIB/O0KVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=0q/7tzPc; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="0q/7tzPc"
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 4DECF40D31;
	Tue, 13 Oct 2026 14:42:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 06F0918;
	Tue, 13 Oct 2026 14:42:41 +0000 (UTC)
Date: Tue, 13 Oct 2026 10:42:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Rui Qi" <qirui.001@bytedance.com>
Cc: "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, "Chunyan Zhang"
 <zhangchunyan@iscas.ac.cn>, "Guo Ren" <guoren@kernel.org>, "Jiakai Xu"
 <xujiakai2025@iscas.ac.cn>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <linux-trace-kernel@vger.kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Masami Hiramatsu"
 <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Paul Walmsley" <pjw@kernel.org>, "Song Shuai" <suagrfillet@gmail.com>
Subject: Re: [PATCH 1/2] ftrace: Clarify function graph retp identity
Message-ID: <20261013104241.5b0aa99c@gandalf.local.home>
In-Reply-To: <20260919033726.1361382-2-qirui.001@bytedance.com>
References: <20260919033726.1361382-1-qirui.001@bytedance.com>
	<20260919033726.1361382-2-qirui.001@bytedance.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: p5xit8ukshspj59ek51dtfti7jox1g5x
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 06F0918
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/QeSNBNV/6H5dKjjhMIcdNqu8bChqKUg8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=mltuhNxTOsPaUjOxKrzrfLEp+rt2GoNa49+Mp4vfRhI=; b=0q/7tzPcSlSbmrx8OyuWlHFfevPxc0X+DStGm+x4p/yCV422QRLw/JEnPpvMFYgH01dB1bThSeWn9Zjm6bjvlAa1TkdWCcLzS9IXkhlJB3wEVs0wsUqAc80KPD/MS2TcTCDJFf4/BfgW2yVaQM9hEIhPpt4/fcPDkGduGUv9P4k=
X-HE-Tag: 1791902561-405228
X-HE-Meta: U2FsdGVkX18eIcc7Z73jyVQ2i3HW7Dg6gCWGyoMpLeogyQEUGJCQT4chYT1g+HGdfnyjHjPv4nDJBAu1Ovm6wFsx+jaKGxjkiOEM5qdemCx8/9hZAsvmLTxU2IhnsDtXQG/W3VU28Rlk26WeZaItFsOefY13cXOtUq9SPgRqsbZKUVhFxMfReoh1Lcw1ov9qqvet94KGjZNPeip9B1W7XsvsONfHFFWBiNt3G/cBmz+5JH8gz9mz0BEfuFSUYN7+0FxB8xjx6NrFsAZY2JAETx36rvoUVG1GGl2wLci0b+z0kXSLeAvMgRUE2WH1MtH9P4j9MouWjHlWrx2tuoCvrOvUhdrpISQuQi0tjw1Nm415tTtGHT4tXNl8JdG0DOCfwOFXKm4GtWQz2+QuLJHT9Q==


Sorry for the way late reply. I stopped being an upstream maintainer while
traveling. I'm just catching up now.

On Sat, 19 Sep 2026 11:37:25 +0800
"Rui Qi" <qirui.001@bytedance.com> wrote:

> ftrace_graph_ret_addr() does not dereference retp. It compares the value
> against the retp saved by function_graph_enter*() to find the matching
> graph return entry.
> 
> Update the documentation to describe retp as a return location identity.
> Most architectures use the stack return address slot, but an architecture
> may use another stable frame identity as long as its graph entry path and
> unwinder use the same value.
> 
> Signed-off-by: Rui Qi <qirui.001@bytedance.com>

LGTM, This can go through the RISCV tree.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
