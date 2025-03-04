Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBF2206F0E;
	Tue,  4 Mar 2025 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100052; cv=none; b=JfktuklShhTWMIF/cgImk4TYn583Z6dQKlVoURj3EYM9LM99w9oeWNe9omRRhcc+fn/PTEMbhEuMmWFsl3dPnaF0T4nmju6jhV2W8L96TcmiHnEzCeFo2q0yb6DVNgVEvfjTQjMNNdsTSBXNxoXJ3Kug4uwnNHYhrFV3E3qgcjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100052; c=relaxed/simple;
	bh=4Q4zxWjZLqidwAgVqrCKtokBWJiuLYC7/zCAHB6hZn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4Gq7RMmllphSx2QUmKY3RaqzCKRvluAgll4tICvDSRwsmM7Zr2td2KOxf0rnpt//kN6xTomGs3hM6AkHADm+mkPO+0wxIamYEzifLBVvkg5EjcreQKVFnR64GGhv/GIuL54e0q9sCQRTaICxSXPddk/9EifB4tZx6Wubdw4OsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DE6C4CEE5;
	Tue,  4 Mar 2025 14:54:11 +0000 (UTC)
Date: Tue, 4 Mar 2025 09:55:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar
 <mingo@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/ftrace: fix boot time slowdown
Message-ID: <20250304095505.4716c41e@gandalf.local.home>
In-Reply-To: <Z8am3EgVK9qADIgJ@kernel.org>
References: <20241124140705.2883-1-rppt@kernel.org>
	<Z07KnNk5AK_Jq6CU@kernel.org>
	<20241210230056.185826cd@batman.local.home>
	<20250303172427.1ae6c924@gandalf.local.home>
	<Z8am3EgVK9qADIgJ@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Mar 2025 09:08:12 +0200
Mike Rapoport <rppt@kernel.org> wrote:

> It's not relevant anymore, the commit that changed text_poke_early() to
> text_poke() is now reverted in tip tree.
>  

Will that be going into 6.14?

-- Steve
