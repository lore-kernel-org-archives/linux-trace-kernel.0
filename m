Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3F9192B75;
	Thu,  5 Feb 2026 01:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770255653; cv=none; b=C9Px8Thhc9iAiGxolX8Tey0iSoxkEOAjAElQ118yzPfMPWWhRCfzdxH2eC2zahpQ0qSL7EfOYGU1ZhrtjSpPuZpI+lVEPK6WfgKV9sxFyhLRQBkktj3fKXeV2lkJo+c81AZ9FHZ3IYrW8o5aTsOqyZOpfQ6WS5eLmvcBG5IUPXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770255653; c=relaxed/simple;
	bh=Q/6NeoQjA6R4o0oUbM/l24D768FnxkNLaHYjTAo8MW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BvuurQYJwW0OjKUmyyP8ZYE+VidTmwyjy0eaUIllyuDZSwysaLEUxtC1GRP7uD4pcI7oF/EJa0WcGKba6gFPmNimqqA+CtRshtNC3e9cDhhK1BXVR/TD6Csr3L1y9Sgc3UI87GHDIbPUzi3IWl7TkLKhBwxmJjHI5QdOvMN+XDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 4291E8B24D;
	Thu,  5 Feb 2026 01:40:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id A827A3E;
	Thu,  5 Feb 2026 01:40:50 +0000 (UTC)
Date: Wed, 4 Feb 2026 20:40:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/4] tracing: Reset last_boot_info if ring buffer is
 reset
Message-ID: <20260204204049.0f7dc697@robin>
In-Reply-To: <176991654703.4025429.9641092475053587709.stgit@mhiramat.tok.corp.google.com>
References: <176991653525.4025429.12655335935351822711.stgit@mhiramat.tok.corp.google.com>
	<176991654703.4025429.9641092475053587709.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: c5dj9q3ayrynyzyj559w1inbpbmfcpks
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: A827A3E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX187QJflEStGrUI5sy+wyFuIEue8eiKg2c0=
X-HE-Tag: 1770255650-426212
X-HE-Meta: U2FsdGVkX1/Ay9Zh0DK2UTqL3uGtSgkg1EQnNMBReEqPT/EpYp59P6PAuAfy2MIVFhex/QtPp/SN6aaxvg0rf3T0aICLI+xCzYEpALY8kNHskrsQ4WGRx1goXIkiLfTaovCpgjA+QniJLlv8OxkEoWBxPAQLXiuOSgvrmIj8iCvt+M2JLsvWZ6g0kccj1wW2gjeUkmo9rv79zv+kEQEd8WP+AChq1lV+TSxuohsB3hyIWVrWQ43cWgxxqcUIhG+frePI2926ZNp3U/X5vKibAisUvz/qUBw7WeBrGIXsYXSSC/2bny59c0rerDgUMZ7H59YI49MtCTPcFfrQLlJukBoXUHjp1wGF2iXNrUSGyVpxnqnxLFR/Bw==

On Sun,  1 Feb 2026 12:29:07 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> @@ -8036,6 +8042,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
>  				tracing_reset_online_cpus(&tr->max_buffer);
>  			else
>  				tracing_reset_cpu(&tr->max_buffer, iter->cpu_file);
> +			update_last_data_if_empty(tr);

Is this needed? Memory mapped buffers (which the persistent ring buffer
is) do not have snapshot buffers.

-- Steve


>  		}
>  		break;
>  	}
