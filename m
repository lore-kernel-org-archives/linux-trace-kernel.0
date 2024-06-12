Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697AA63BF;
	Wed, 12 Jun 2024 01:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718154861; cv=none; b=VYXuDO9VnJDJ+EHOGa9B/UsisA9JVm21WtO+9qeVaKPnm6LqVC26ifl2WI2onSHkd6oZEhvCPZsgfFhKJl7o+hlNLvcWNs8wE9/Y3IXEqI/Qv3v06PTlwUvHB0/N7taWEtp1bNkPaPSiHSrEnVJ+UOJPGL38K7FQTw3uJmGFlM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718154861; c=relaxed/simple;
	bh=wMwA7rRiU+KEJU3UIhHW2aLK92hemOoQCOYfZvmh7Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EToi4PtdYASrHeBtjBAmv3947DzgZ/VVelNSKPQJywDUSLgbjxwDLMT6LBwXtoSe6J7ylpfgOnkIXio66brLAFANBCkvnGdVfMZl6aa0CHk9enSOgtIpM551z1YfFG0D5kqSJtqjPeOHGUWSVfXDNNCoOxWfMzHUL4h9OLBbXA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F40C2BD10;
	Wed, 12 Jun 2024 01:14:20 +0000 (UTC)
Date: Tue, 11 Jun 2024 21:14:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 3/3] tracing/kprobe: Remove cleanup code unrelated to
 selftest
Message-ID: <20240611211436.7a0a0e1f@gandalf.local.home>
In-Reply-To: <171805481328.52471.14726358281044398289.stgit@devnote2>
References: <171805478534.52471.6269290579314514778.stgit@devnote2>
	<171805481328.52471.14726358281044398289.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 06:26:53 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> This cleanup all kprobe events code is not related to the selftest
> itself, and it can fail by the reason unrelated to this test.
> If the test is successful, the generated events are cleaned up.
> And if not, we cannot guarantee that the kprobe events will work
> correctly. So, anyway, there is no need to clean it up.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
