Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078193ECBE7;
	Fri,  6 Feb 2026 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770385855; cv=none; b=KHmNpOCjL8Zg7N4SqFGs4ZCvaDmYH/IJhlErHFbE4cXUZeqrp3oavcZuvKAk35sk2Jc2zcROlJTbSuoOJKKq5dQM1+vkO34O1Cr2Uu41ILOhq0SpeVpG5MQM/ACVTW+kAIvdhkDmc1eg4go8CMigQgBGQMl8X1N132/98cn9B28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770385855; c=relaxed/simple;
	bh=42ymS8CzfD+zZEraJYUjLCCnis3YiWOkb/A2noHjnQM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IV4hzpRRgjgF0d/Bp4M/0g0+OX5QRflrgn2hh9La6K0P7qN4HkjSHDViZ7c0Bmri7qgsf70UK9vmHw8WRtcSU6mrLPI7Eq32vNsFOpw65sl7H3eISUIdbReFeoOS/6Pj0Tr7rO1wdozPebM1ei9CMSLDNd4SPbPx+CuRIfz1+dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7FR8h6S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7FR8h6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A610EC116C6;
	Fri,  6 Feb 2026 13:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770385854;
	bh=42ymS8CzfD+zZEraJYUjLCCnis3YiWOkb/A2noHjnQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M7FR8h6S1uY6p6IrtA+dMOjiHs7ZRLHuc1AzXon1CJ/cFhrU6ClocIUjv+uGoiPSF
	 is1+KczSovv6bT3ZNMVIebleu7RmVcoH4n+o8s+Ng5JI/LBNPUA5vle2N04WJnh0jW
	 c44RdFirjzAcMyJLK9D5GVLuZwJY+w43jHiFTljnVkc2p93npb4Jira9nrOKEOgHPS
	 yR54KyNZ/02DTWsaoXT9gPnBh/0PIQFp0gKqAvjGfITXNTHi3avihU7KXusakckJco
	 IUYOe7AaB+v4amgeD4hMgmtuCNZqoTBHMdHWjlhJKF/5fvYSR/OsCYTwZHUTK48rlV
	 +K9PAHcS+Sj+Q==
Date: Fri, 6 Feb 2026 22:50:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/4] tracing: Reset last_boot_info if ring buffer is
 reset
Message-Id: <20260206225051.f22b670b54e8906a4bc1bec9@kernel.org>
In-Reply-To: <20260204204049.0f7dc697@robin>
References: <176991653525.4025429.12655335935351822711.stgit@mhiramat.tok.corp.google.com>
	<176991654703.4025429.9641092475053587709.stgit@mhiramat.tok.corp.google.com>
	<20260204204049.0f7dc697@robin>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Feb 2026 20:40:49 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun,  1 Feb 2026 12:29:07 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > @@ -8036,6 +8042,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
> >  				tracing_reset_online_cpus(&tr->max_buffer);
> >  			else
> >  				tracing_reset_cpu(&tr->max_buffer, iter->cpu_file);
> > +			update_last_data_if_empty(tr);
> 
> Is this needed? Memory mapped buffers (which the persistent ring buffer
> is) do not have snapshot buffers.

Yeah, I did this just for consistency. But it is better to just leave
the comment here.

Thank you,

> 
> -- Steve
> 
> 
> >  		}
> >  		break;
> >  	}
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
