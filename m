Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565BC5025E;
	Mon, 15 Jul 2024 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721069989; cv=none; b=T+BctRV0EQRBB5xlg0LPhZxDF96dpwkPccsB0BOy02FVa/06s3XqVh1hze4e4No2iZR6KoG4GPIxyguN6d1pzhN87EsKML9Oh3VA5513YHIIbfhOskBkscZTDCXNn7dhOmkVwyzod5HJJ06bi4UDFsMbwHOvzi/q28fpPJhgNOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721069989; c=relaxed/simple;
	bh=ZgGW9bXZE/kLmD96/SJrjdcH7vZ/Q8YeO7mIIIGKzzY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WptsDtKWP+ICyq4UfQsBcCjcZWNeQwDD8+fo754EfPT13FKB9dtw66ddQ//tG6LIVb2VTsYokrf7XP0XULIXleXAdIhuHDppsWYXjXEhpBaEZzW80IeMZaaOnxvD6va5FvIRuuNuBza9iaQWboK/QnpPdl7VODctojJJgJ8S6cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08443C32782;
	Mon, 15 Jul 2024 18:59:46 +0000 (UTC)
Date: Mon, 15 Jul 2024 14:59:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com, david@redhat.com
Subject: Re: [PATCH v2] ring-buffer: Align meta-page to sub-buffers for
 improved TLB usage
Message-ID: <20240715145945.17408deb@rorschach.local.home>
In-Reply-To: <20240628104611.1443542-1-vdonnefort@google.com>
References: <20240628104611.1443542-1-vdonnefort@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 11:46:11 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> This is based on the mm-unstable branch [1] as it depends on David's work [2]
> for allowing the zero-page in vm_insert_page().
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
> [2] https://lore.kernel.org/all/20240522125713.775114-1-david@redhat.com

I'll hold off to 6.12 merge window before pushing this. So that the
above will be guaranteed to be there.

-- Steve
