Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52F63502A9;
	Tue, 26 May 2026 19:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824318; cv=none; b=RQCF/6qqxtNe15OQczmF/SrMxutU7VbU8IfVA9nNw8t++KD1gQjW5HZnY6BCAiC9nASDix+509Jpc5ceMyw+150rrYgDWKa88NxW0Vw21j8MqfR1cOoVY6oBJzrQ7iUANkufs+g6iyvNLqaC8nFVdmGNMvXg1O8FDHv9hAOQU40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824318; c=relaxed/simple;
	bh=CdYJ6KR1CDql6op/8GOtX7NEid5/rNSsu5HinRhlJz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMJPKLLpaYreUH4tefqSPu+Eue8HW0Lgjr7xQJLZUtFvpHSKJOiLSTwMRxRbxhab0qk3z2/2Y+awkHGhWEvOQ/Nz+exowFCY2QIZMoJyJUTGEtwX1eeaewlizrXSCWpbcgKkEj0AHGRpo2qOnbQljgitkaNoHOtv7ycY6GWbD1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 1A2461C0252;
	Tue, 26 May 2026 19:38:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 421D420018;
	Tue, 26 May 2026 19:38:33 +0000 (UTC)
Date: Tue, 26 May 2026 15:39:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Li Pengfei <ljdlns1987@gmail.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, cmllamas@google.com, zhangbo56@xiaomi.com,
 Pengfei Li <lipengfei28@xiaomi.com>
Subject: Re: [RFC PATCH v3 0/3] trace: stack trace deduplication for ftrace
 ring buffer
Message-ID: <20260526153905.093aff7c@gandalf.local.home>
In-Reply-To: <cover.1779769138.git.lipengfei28@xiaomi.com>
References: <20260514034916.2162517-1-lipengfei28@xiaomi.com>
	<cover.1779769138.git.lipengfei28@xiaomi.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: i67ccpnwu5hi8ghnrj15wjm3tjc6n6fo
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 421D420018
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18eqGLafxeHNCocGVTpJ7gz91e6br6vH7w=
X-HE-Tag: 1779824313-272225
X-HE-Meta: U2FsdGVkX1+7DyxMBWuTXOs+Jjrs5LgDO55IofuHUZRLlUm+ry4zo26DKsKoK4U8FcY9J0prjwv/lmjlQf+9ON4qjh/gnLZkUGkTJp8xVUIeuaIeoJfdb3ZqlUdVpA8HgFbmYGEOu75AJi9s42HPyu2da082NwwMaXBnPRSJvPx9VI0LM1YOqd8rG/7c/6BHEW7o3LAUFd3yolVwKsexuGn3hvxaPf0/cMfj7d9WwwpCqG94rtlxY4jX0JAC2IlAwpVpuO/YWCgjP4akpukM0/s4z6uNVDNwWtOoZvlYSiD/ZKyCKwj5NgOXc0R1kBzVRYEoJGviQRKqlAEH9YekD+1kznC8m1W+ckXHUHgwza92ak48kUDojCN+s6Gb813Sn5urT+GBJJ1rAI0v4BdcXldk+Iu2dv3IjgwwHkOYucZO/wlXKWnx7GTp1HF8KwmHDoktfPrONqg=


Please DO NOT SEND new versions of a patch or patch series as a reply to
the old one. It makes it extremely difficult for maintainers to manage the
replies and patches.

A new version should ALWAYS start a new email thread!

On Tue, 26 May 2026 19:52:42 +0800
Li Pengfei <ljdlns1987@gmail.com> wrote:

> From: Pengfei Li <lipengfei28@xiaomi.com>
> 
> Hi Masami, Steven, all,
> 
> This is v3 of the ftrace stackmap series. It addresses the Sashiko
> review on v2 [1] that Masami pointed out.
> 
> [1] https://sashiko.dev/#/patchset/20260522104017.1668638-1-lipengfei28%40xiaomi.com
> 
> The series adds stack trace deduplication to ftrace. When the
> stacktrace option is enabled, the ring buffer stores a 4-byte
> stack_id instead of a full kernel stack trace, while the full
> stacks are exported via tracefs.
> 
> Rebased onto v7.1-rc5 (e8c2f9fdadee) before sending.
> 
> Changes since v2
> ================

Then you can use lore to add a link to the old version via the Message-ID
of the old version. You can have the above as:

 Changes since v2: https://lore.kernel.org/all/20260522104017.1668638-1-lipengfei28@xiaomi.com/

-- Steve
