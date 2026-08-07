Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ECA41DDF3;
	Fri,  7 Aug 2026 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786098560; cv=none; b=QIObZdE11qhI/C4XCDPOpM3/8qHVAm/BBvNVR5u3KFEVbQTfJriBkgVLTinm7jpsaj0IUZOhTGufhwiKB0D5xdsKxwnrqItY4L0ZKG4MnjOIZqPtWEl/Bgc47ML7EqGEvZUtY8g7TMPhBzHFbXztU9CnZ4/vOWgPGTBFwZPr2TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786098560; c=relaxed/simple;
	bh=8eyElfowWGD8Q5pEz0DPFFspUw/+KmZcnq0VXvWsOmQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=J0Dzx4PSC2nKRTdTOL95tkNZaL4TBiY8hkfRNPvOwZyGnpxnIUg154eSSP2jmdfMzWO0i6Ol66vS4afCmYTwIk/HZKKduZPwLyIJ2G13p1AlljLiHAm2IR6HF9ilIjqnXg9pvKK6YAYcieUxmDnq4G+4tEiGOfEQERTuXXfYr/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZX+xu6s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZX+xu6s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC791F00A3F;
	Fri,  7 Aug 2026 10:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786098558;
	bh=t8j5WYCzY0H57A0w7FKCm+dwHMl326i7/RT7YhqeiGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UZX+xu6sPM8hbIgDLIjOZLqHDBJpVotzzeHv4Ffg9ONZr5DDawKxaYeGGMjuNWNNk
	 O29MZXbVQr4eEypn7/DEw0pTN5Tv+4A6uKIL53acqX0WBVIs8sRv6fy+AwYYQeeURA
	 CFsKEgHfh6n3+TdZ4w9ZSztogKBZFPR/PWnPLkYiJJSiy13I9URK3fMNGasJpTn9cv
	 911ECLOfG+beIYqW3XHlqwh/IwBcAFrzs+F7lYeCdT0W3/pZOi19imsY0mIJLQH+p5
	 u5sPwhjJxUYcSx7OLjAQwJ8FwPp3P3FIxWq9A5onnJ9eoqX3/9I7IWD+fch6tjfFAD
	 Klx4SiRTxM7tA==
Date: Fri, 7 Aug 2026 19:29:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Rui Qi" <qirui.001@bytedance.com>
Cc: "Steven Rostedt" <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Shuah Khan" <shuah@kernel.org>,
 "Heiko Carstens" <hca@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] selftests/ftrace: Fix add_remove_uprobe
 robustness
Message-Id: <20260807192914.afd2a3ee624fecd760232d12@kernel.org>
In-Reply-To: <20260807081512.2974757-1-qirui.001@bytedance.com>
References: <20260806083101.2651025-1-qirui.001@bytedance.com>
	<20260807081512.2974757-1-qirui.001@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Aug 2026 16:15:10 +0800
"Rui Qi" <qirui.001@bytedance.com> wrote:

> Hi,
> 
> This series fixes two ways add_remove_uprobe can construct an invalid
> uprobe offset.

Please send the series in the new thread (not reply) next time.
Instead, you can make a permalink to the previous discussion from your
mail's message-id and write it in the mail body so that we can follow
the discussion in the previous version.

e.g. 

 https://lore.kernel.org/all/20260806083101.2651025-1-qirui.001@bytedance.com/

You can get this using below script.
-----
#!/bin/sh
#
if [ -f "$1" ]; then
  MID=`grep -i ^"Message-Id:" $1 | cut -f2 -d: | tr -d ' <>'`
else
  MID=$1
fi

URL=`curl -Ls -o /dev/null -w %{url_effective} http://lkml.kernel.org/r/$MID`
echo ${URL%T/#u}
-----

Thank you,

> 
> Patch 1 follows Masami's feedback on v1 and forces the C locale in the
> top-level ftracetest runner, rather than setting LC_ALL=C around each
> readelf invocation.
> 
> Patch 2 fixes the remaining offset issue. readelf reports the ELF entry
> point as a virtual address, while uprobe_events expects a file offset.
> Convert the entry point through the LOAD program headers so the test also
> works for non-PIE executables.
> 
> Changes in v2:
> - Move LC_ALL=C to the top-level ftracetest runner, as suggested by
>   Masami.
> - Keep the entry-point-to-file-offset conversion as the second patch and
>   rely on the runner-provided locale for readelf output.
> 
> Testing:
> - ./scripts/checkpatch.pl --strict -g HEAD~2..HEAD
> - sh -n tools/testing/selftests/ftrace/ftracetest
> - sh -n tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
> 
> Rui Qi (2):
>   selftests/ftrace: Force C locale in ftracetest
>   selftests/ftrace: Convert ELF entry point to file offset in uprobe
>     test
> 
>  tools/testing/selftests/ftrace/ftracetest     |  3 +++
>  .../test.d/dynevent/add_remove_uprobe.tc      | 27 +++++++++++++++++--
>  2 files changed, 28 insertions(+), 2 deletions(-)
> 
> -- 
> 2.20.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
