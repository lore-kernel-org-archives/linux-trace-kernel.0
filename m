Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08591F0E36;
	Fri, 14 Mar 2025 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945380; cv=none; b=ewzjVmZ2L4rFMlxvUmlg/6zngT6Jv0gWzfcifL4q5C58Sx7KLeAi+yFDAzJBMpg0HVlj4AvDWh6tirYRQszudC7zZ2ZbqEhVHkHEueTghE/VocvZ+CqTkWqOZ3PRPm7ArOU1on9rih3Wm/W7jin9PA9j0EZLrJ2+NvQQboNvGZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945380; c=relaxed/simple;
	bh=pbuFAEq3Ui4gAVsdTa4CTZ9yK5iev535hiEefZtJf3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fG6B9aM0OFmKagqtnzzsTGA8drAjjTt8UhrYwtRgnEQsIqHkpITeR5UE0V6vo0LzvRtV2E0NdNi5+bbY4DHzjX/++mQEkiNzKQC79UCsRBvtPWeG1Rt7uhGn7rf7XbGX/tMg+zZhrC/jqLD5jsWCPgNtIgrdMlKbXePrRu+Hgc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64954C4CEE3;
	Fri, 14 Mar 2025 09:42:59 +0000 (UTC)
Date: Fri, 14 Mar 2025 05:42:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] tracing: Fix a compilation error without
 CONFIG_MODULES
Message-ID: <20250314054257.3218dc35@batman.local.home>
In-Reply-To: <174188321162.3845006.12665585959241736399.stgit@mhiramat.tok.corp.google.com>
References: <174188320269.3845006.11920186078507571954.stgit@mhiramat.tok.corp.google.com>
	<174188321162.3845006.12665585959241736399.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Mar 2025 01:26:51 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> @@ -6040,9 +6042,10 @@ static void update_last_data(struct trace_array *tr)
>  		memset(tscratch->entries, 0,
>  		       flex_array_size(tscratch, entries, tscratch->nr_entries));
>  		tscratch->nr_entries = 0;
> -
> +#ifdef CONFIG_MODULES
>  		guard(mutex)(&scratch_mutex);
>  		module_for_each_mod(save_mod, tr);
> +#endif
>  	}

Hmm, I think the real fix for this would be to make
module_for_each_mod() a nop when modules are not configured.

-- Steve
