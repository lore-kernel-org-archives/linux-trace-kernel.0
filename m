Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6AC271800;
	Thu, 27 Feb 2025 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693332; cv=none; b=TPXazgJlw94ngXYI5aG5NH33fkG0QVDJpEYuPT3cX2L+g6Nvn5ttQSYSNKQbTY7GloqOoRbbyx1xuCCRb0PnTztjgQjkJfkyzkR/Za5SqE+PrZM5ftCEtZumehl+ghrJ5mwi9sznNcoAOdmAScw2KXnb1f6lGLesurmWwt6IycA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693332; c=relaxed/simple;
	bh=hDyuAfHW61npSm/JhvU/ozsnDVR+qeOoacvorcXx8A0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ern7NgMNY7JXrVZG+4sVjAMvDj9GMAgV+FjOGej4E1ApNG3zmFqHX3UCnPt1aOk9xw8TBg0bGLkqnX3iPRvbM8QX96mh0MZbP3yhkc+xsXKGH3CO+dauJynoyepw0pnxokHchtkSJXVrHCX5BcKWwADS5wN6qEMVgY1nyW97Zaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6C1C4CEDD;
	Thu, 27 Feb 2025 21:55:30 +0000 (UTC)
Date: Thu, 27 Feb 2025 16:56:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>, Tomas
 Glozar <tglozar@redhat.com>
Subject: Re: [PATCH v2] tracing: Fix bad hist from corrupting named_triggers
 list
Message-ID: <20250227165613.75f7e3b3@gandalf.local.home>
In-Reply-To: <20250227163944.1c37f85f@gandalf.local.home>
References: <20250227163944.1c37f85f@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Forgot to say this was v2!

-- Steve
