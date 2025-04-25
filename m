Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7B27442;
	Fri, 25 Apr 2025 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592322; cv=none; b=dVdDaAMEBejr//tUKgEAJfwWL4zffjYlmYB5PkfMy+/IcLXCsKFPzOrI60QGYczPm32L3wZ+dwuyO2t8oxn/G1Bwk1JFtSad1pc6bMjcrh6aSXBWMDy9TOGCOoK/qOEp+RFXqej+mwUeBGK+7vkMEDJO9AgCMFSd/p4CFGKRrE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592322; c=relaxed/simple;
	bh=EFZZ94mA6KyWylrAfqi5vnrJcQuvtKXbd+z4CjYOqyo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p+0+7GedYjlbRYylJfN517O0L3whAxD8zFndnEZ7kvTq6hFRe7D3s1xUpEoUdE8s9d8LkDptBljBX6vcfXZoU3kwlvOGYBrFpzJfRML5TyPAULe5uoOjrqYpwKfNrQgCv1oPl5e3AtREx62ecFqmgU/VhBRbinoBAE7CMI0ZUV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8E3C4CEE4;
	Fri, 25 Apr 2025 14:45:19 +0000 (UTC)
Date: Fri, 25 Apr 2025 10:47:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Jens Remus <jremus@linux.ibm.com>, x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Indu
 Bhagat <indu.bhagat@oracle.com>, Andy Lutomirski <luto@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 0/6] [PATCH v6 0/6] x86/vdso: VDSO updates and fixes for
 sframes
Message-ID: <20250425104716.2051a17f@gandalf.local.home>
In-Reply-To: <20250425023750.669174660@goodmis.org>
References: <20250425023750.669174660@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hmm, my scripts added an extra [PATCH ...]

I must have done something wrong. :-/

-- Steve
