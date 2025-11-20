Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D78368E03;
	Thu, 20 Nov 2025 20:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763672197; cv=none; b=dapIVzo1+9h0cJ+HTkL+rhA0kS6wBIDIgNIdNkwE4EEqIaxzOjQkCDM3D42/UYQioDWb3d5R/PQtT6dKOM2fw/y0JxbFQxOg0qsUJCuINAg/2Csh/0SJTW0PCP+TMRs6O1YcA1njWfjfpn7g4gt1cb14yhoX+Kx4UR9aG97KKDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763672197; c=relaxed/simple;
	bh=PVRNTByH8JPL0tWbY2qQfYwJagGniGxY04/CYnak3Go=;
	h=Message-ID:Date:From:To:Cc:Subject; b=DbEo+FjrZObMnw+LKLr9g4SqC96eBv0ZjJs+orEBuXCYLowJTIEoVFVkpBrhMGrAmSO0n+83yMdx6ABA0YP4w5f4vvuYT6TFSv5X8HyOlObDWs6Q1Un/cHkv11nNREAfpzThiiEdJOnp+CrRH7TTA2WrQM/vR8aJ4tA9KOK2Uys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PErrbxyl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PErrbxyl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B50C4CEF1;
	Thu, 20 Nov 2025 20:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763672197;
	bh=PVRNTByH8JPL0tWbY2qQfYwJagGniGxY04/CYnak3Go=;
	h=Date:From:To:Cc:Subject:From;
	b=PErrbxylAJISLR5tYK5x2pvmxc923BY8fZ41O0J/xF6WrFFO+7VT/1dI5HFlyLwFA
	 Hqr3Q2tJty/USxgPBw5K2DssMqix0sBOCp08EYQismrV8Lyxpnv7Clzi30omfObI43
	 ZUWLqGtB2c1AEUSpR0Q5tTOzkxpoz9cgYAdBi1mvQHxusJv9qols15+HQrCZRNv6Rk
	 IRfgI8iVGxJ0vfA/udy2tj4miOdRthWPh/nO6vp7L5DfSGjxKkVLsSyzBKis2pV4LB
	 O+vssy9Btgp7Ud1TR824i/dXpMqGAYPV7n8tOA7LO7BNjfTzk3zV79wpzSPbCnsR7/
	 Lq/neeaEcqe6Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vMBiH-00000003zAu-41Ko;
	Thu, 20 Nov 2025 15:57:09 -0500
Message-ID: <20251120205600.570673392@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 20 Nov 2025 15:56:00 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 0/3] tracing: More clean ups of triggers
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

This is based on top of:

   https://lore.kernel.org/linux-trace-kernel/20251119031042.328864818@kernel.org/

Steven Rostedt (3):
      tracing: Remove unneeded event_mutex lock in event_trigger_regex_release()
      tracing: Add bulk garbage collection of freeing event_trigger_data
      tracing: Use strim() in trigger_process_regex() instead of skip_spaces()

----
 kernel/trace/trace.h                |  1 +
 kernel/trace/trace_events_trigger.c | 65 +++++++++++++++++++++++++++++++------
 2 files changed, 56 insertions(+), 10 deletions(-)
