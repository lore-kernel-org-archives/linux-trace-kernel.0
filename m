Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E552DE6F5;
	Tue, 25 Nov 2025 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764106787; cv=none; b=jx0q9sXlejbyepRVz2voAIDFjRQinklLk7czu8xt5IWcvrykIoDtEB9boQvxw9v8d6834v9OWoPIdAY7fLERDfWUWpxyFoVU9eXHtilh8sBUbtfyYigCalDc4cvGBipRYxIyGb3mbB//XHbl8nM4ovWY7bUf3PO7ItRR3mPcKK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764106787; c=relaxed/simple;
	bh=A8Ox5rn+0rT23avpHW9E0bEFaDIFpL6DjOhEPCcsd3w=;
	h=Message-ID:Date:From:To:Cc:Subject; b=p0qTTvvnIzPoT1/XNHaHYhN/xQJtpiiihX/2v7r+PQdtlmUSrJFrL1FtinzmrM3NdtcmKdtfdazrZpLIKsY5ATGMUgSpg8UEKZPPYzvv4jZKw4qhwj8JjYZAxiDGFa4KZd37ev4oiYaYEL5Woe7G8ejLbXHKBSCTbEWtVTvF5dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDjgKl3l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDjgKl3l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F64C4CEF1;
	Tue, 25 Nov 2025 21:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764106787;
	bh=A8Ox5rn+0rT23avpHW9E0bEFaDIFpL6DjOhEPCcsd3w=;
	h=Date:From:To:Cc:Subject:From;
	b=YDjgKl3liLYzRqRQnvuU2Fc22qcWFtwdaSs09GLwOjfso8MFAormQOqMXm025EKzG
	 nvf6RfgBMGvBPnSJckMHpP0igVK+COgXm4+Ig4OU1ZlhAX959cfnasRkp7nQa5C6HI
	 PB0o9dJ6eL9sV9+p1dhXOkKOzSEeNxTTwkw87400Sa7RKyKhNgazXQa3XynsFImziR
	 96HWupyOG9b7U6dGxkN78pu+Q/fZB5hItEolsSCuSu5hu49wPF/FKbO0vY0OKFpfcM
	 A7U4DDbEyawo9Dl34wUm0dwXiYHYhPctQKR07jv3zQwU5vVlr2bHNe1TgYsFbafbRW
	 4Cq4rBgg8+y0w==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vO0lz-00000005rNP-3yjv;
	Tue, 25 Nov 2025 16:40:31 -0500
Message-ID: <20251125214004.396482401@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 25 Nov 2025 16:40:04 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v2 0/3] tracing: More clean ups of triggers
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


This is based on top of:

   https://lore.kernel.org/linux-trace-kernel/20251125200857.975524485@kernel.org


Changes since v1: https://lore.kernel.org/linux-trace-kernel/20251120205600.570673392@kernel.org/

- Moved include of llist.h to trace.h as it is used there (Masami Hiramatsu)


Steven Rostedt (3):
      tracing: Remove unneeded event_mutex lock in event_trigger_regex_release()
      tracing: Add bulk garbage collection of freeing event_trigger_data
      tracing: Use strim() in trigger_process_regex() instead of skip_spaces()

----
 kernel/trace/trace.h                |  2 ++
 kernel/trace/trace_events_trigger.c | 64 +++++++++++++++++++++++++++++++------
 2 files changed, 56 insertions(+), 10 deletions(-)
