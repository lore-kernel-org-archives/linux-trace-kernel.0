Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A2C156231;
	Wed, 29 Jan 2025 00:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738109974; cv=none; b=WzS++idcBAF4XJ8PbCPouRdhThJv6OgQmBO/JnMnxsoadpp2KMYxGg6mROY8nUcyU+wYjX30C4XMESTFc1Q/acer80g2qAIF7ZdR6PPXHE5v32Vzfb3Rt54/CZuJStDM/OvR6AGlkrZpINb+f2EHMipDilHN/jVjXEbt3MKDNrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738109974; c=relaxed/simple;
	bh=UP7OliruV+loNSCbX+kLpVRGvq5ONRXwMg/FtexDS2k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oM5I4e3nribO7hrTIqGCtUfpu2LD+toL49hFLbY+Vwm3Q0VNIGpp+ovzuuBV8ipBqZvO9kWGs1m2Eoydh3mmgRh+pfJsN051Zv40GUkTNDNsIibFbi08XIVqmVh9Db6EDsZkIeIyGB+VvZ5rCt42HR2s3p0enVW22N0zVW/duFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mh1Bsgfl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mh1Bsgfl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A43C4CED3;
	Wed, 29 Jan 2025 00:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738109973;
	bh=UP7OliruV+loNSCbX+kLpVRGvq5ONRXwMg/FtexDS2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mh1BsgflJqVHBc/gJlND4gi/uVly9wogeXyB+Nazx0p5JPJZXEkXYEYQgJ0qBOgoC
	 FXF4eS5vMD1Frh7eU62Mid34Hd/0QsyDnYXigTXz1yUyrpp+u8h5eNP/1/FknYoPEm
	 ABspYPN7mlXysB3h7COrsH2SLy2ZMmWrP9MoyRILnhm6CrhETCM3UtdaS6lRMAQSOM
	 h5dApxCCcr6jmiw3Yunp229XgktEwPD/rzZVJTOVrz4ektbARuEOmt07wRzgcsGn7v
	 VkOHwXfC1GwlRz05q3YWyj9v/YcJWX7fR75Kv5BLzuA0aupDG562Ci7dAISKcmuWdT
	 6ssPSiMC3TCew==
Date: Wed, 29 Jan 2025 09:19:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] tracing: Introduce relative stacktrace
Message-Id: <20250129091928.d51fb8563f0291a075c0e200@kernel.org>
In-Reply-To: <a7a171c4-7feb-4f26-a832-18d38a3ee973@efficios.com>
References: <173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com>
	<a7a171c4-7feb-4f26-a832-18d38a3ee973@efficios.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 10:46:21 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2025-01-28 10:36, Masami Hiramatsu (Google) wrote:
> > Hi,
> > 
> > This introduces relative stacktrace, which records stacktrace entry as
> > the offset from _stext instead of raw address. User can enable this
> > format by setting options/relative-stacktrace.
> > 
> > Basically, this does not change anything for users who are using ftrace
> > with 'trace' text-formatted interface. This changes how each stacktrace
> > entry address is stored, so users who is using 'trace_pipe_raw' needs
> > to change how to decode the stacktrace.
> > 
> > Currently, the stacktrace is stored as raw kernel address. Thus, for
> > decoding the binary trace data, we need to refer the kallsyms. But this
> > is not useful on the platform which prohibits to access /proc/kallsyms
> > for security reason. Since KASLR will change the kernel text address,
> > we can not decode symbols without kallsyms in userspace.
> > 
> > On the other hand, if we record the stacktrace entries in the offset
> > from _stext, we can use System.map file to decode it. This is also good
> > for the stacktrace in the persistent ring buffer, because we don't need
> > to save the kallsyms before crash anymore.
> > 
> > The problem is to decode the address in the modules because it will be
> > loaded in the different place. To solve this issue, I also introduced
> > 'module_text_offsets' event, which records module's text and init_text
> > info as the offset from _stext when loading it. User can store this
> > event in the (another) persistent ring buffer for decoding.
> 
> This does not handle the situation where a module is already loaded
> before tracing starts. In LTTng we have a statedump facility for this,
> where we can iterate on all modules at trace start and dump the relevant
> information.

Thanks for the comment!
For the persistent ring buffer, I think we can enable this event in early
boot stage which allows us to store it. (But this overwrites the previous
data, hmm, we need A-B buffer...)

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
