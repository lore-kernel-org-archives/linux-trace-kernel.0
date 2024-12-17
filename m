Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194D54C74;
	Tue, 17 Dec 2024 00:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734395916; cv=none; b=UtJK4SHbDVn1Ycv76O4VCtLtz/D4iKnvQFbkA45qZ02tcSNmQMELeAmygQ5pMi8oYtAaWe3+y5rvG4WA8iSrDJKP3Iv6WINDGiv3npcT+iBuE7uBALGyOOK9yD6nXQqg92RedQvf+q18yQiJUBRgMUSsyiKCCj3GK/ceLhKwhR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734395916; c=relaxed/simple;
	bh=fa7o8eKOstFkuVP2LlNnMlYqF1CnYsYRlMqFsYL3B6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftWxhBuPJfSV+BLSzv0W3MDW+d0K13adPINywWrq9Jf7tb+uis8LebpLNI7N6zbQMPF8vguJQQ740TqRd2xJtC113KJrl3//wuFewXcRGkMVd31V53mslL5aC+y4YNl4DNcgQFJjXuQVRhTf46rXCQA/c8W5ctjsVCo2V3+dEjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fg0gPduz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fg0gPduz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9136FC4CED0;
	Tue, 17 Dec 2024 00:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734395915;
	bh=fa7o8eKOstFkuVP2LlNnMlYqF1CnYsYRlMqFsYL3B6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fg0gPduz3TA2UenK85geQ4PFJWv7Z1A7C7/Vky5Mo9VNP2bBmwMvrQT/7I1KH7BmU
	 k79myuHv4iMpquknf639meDZV9XlKXB2qN2GQhFLWfH7UaguA2NUNTh2Zrws4eQDw7
	 VlFdOJAnjvraM+m1DEJ3/b5Vr+YTPXL4nQGqfQnGKEvNcSt7lgn9ywVzxQoDC9fIGd
	 30uY/+fwgmUTQAyEXjpRw2Bs/DfvXdARoAZ3hvysywQ0asPH1VgEEl1RRpvb/LFAju
	 jDKOLKd4YsL9HGmTyJwI0LvrJjcmSZ8NUyZRsIrIqCAnW3z04p94OzaWuKAMo7+Eo0
	 ueOf1fbaLPZiQ==
From: Kees Cook <kees@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Kees Cook <kees@kernel.org>,
	Marco Elver <elver@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 1/2] tracing: Add task_prctl_unknown tracepoint
Date: Mon, 16 Dec 2024 16:38:26 -0800
Message-Id: <173439590402.2288303.6690589716880149969.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108113455.2924361-1-elver@google.com>
References: <20241108113455.2924361-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 08 Nov 2024 12:34:24 +0100, Marco Elver wrote:
> prctl() is a complex syscall which multiplexes its functionality based
> on a large set of PR_* options. Currently we count 64 such options. The
> return value of unknown options is -EINVAL, and doesn't distinguish from
> known options that were passed invalid args that also return -EINVAL.
> 
> To understand if programs are attempting to use prctl() options not yet
> available on the running kernel, provide the task_prctl_unknown
> tracepoint.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/2] tracing: Add task_prctl_unknown tracepoint
      https://git.kernel.org/kees/c/57a6baf3a3ea
[2/2] tracing: Remove pid in task_rename tracing output
      https://git.kernel.org/kees/c/a6115cceb1dd

Take care,

-- 
Kees Cook

