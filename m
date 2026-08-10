Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BE440BCD1;
	Mon, 10 Aug 2026 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373951; cv=none; b=oy7TFiV632xdlUGixjIMOomRQ1oiqnmzuLbkVsLkH0D0VLaYHvgM0TaFgFOo7uTB1/i/NJO9sqb08gpXUQj5aZfQvrrxsAVjQQ4o/snS9ZHRtax+Zsa0KJDAWcBWijjCCsX4CnKVdX7CLNzlt5wB7dzEcuVc3lsFd0N3o9Jw1fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373951; c=relaxed/simple;
	bh=6oaD6Y/WO5GY8LOX2fIeqDfX2/uh/iYrW5EFkQLNIvU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzfioj2+NQVDB86uZwQOqMhWv3u/Phd7VLPW9u0K9SSkAC0iGNjxMdzdr3DjfdLS1Wz8PWpCYkfM2HuFqfq8F1uBIC2gI4SatUNUqHzSPhN715Xo0sXZEhqt26SldyLli6t71P9y4Ugrcjq51jwJP6ZC54mWybAlMRRNIlFbL30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 64FCDA19EC;
	Mon, 10 Aug 2026 14:52:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 9C60B2002B;
	Mon, 10 Aug 2026 14:52:50 +0000 (UTC)
Date: Mon, 10 Aug 2026 10:53:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 0/4] selftests/ftrace: Add a boottime tracing test
 framework
Message-ID: <20260810105300.1aed1c7d@gandalf.local.home>
In-Reply-To: <178635442508.380779.3709136256425432083.stgit@devnote2>
References: <178635442508.380779.3709136256425432083.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 9C60B2002B
X-Stat-Signature: ap1ui6gkom7jkwfm54g59b1yp5exqmz8
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+2ckMmgq/v6NfTetdZEKhhE+8XwXI3Brs=
X-HE-Tag: 1786373570-538850
X-HE-Meta: U2FsdGVkX19sBzX9roItXbYIBXkKxxqOHxJNt1eWHmRG+vKs8J0ESdLtSw7UI1jE60cn8nM+i/+wo63neYRYPF5Z+eK1ms+bS0j4KLIUD6NgB9OyyS4QR0lIFj24DNoQndTr0ePj+8IvpCQdxtKSeXlOU5ZGR67VM88u2abxOJf3gnUb3BatVTKoKSRBgKMUGC1c9y5Ae/p8TPgKtWo78wCvOn1K+l6OWL6OAGj9zaVDm6trSgy/ikYNjwhvQeO2iEl8rUGjVF0F5bVNqUsDcgk5ewlOsEZNqHEmvnqhTF+dhXpcUlmWZw7XKekboSWRG3zqvV8lGArvw2ZnUdCdF+F3eLB8ZiLM

On Mon, 10 Aug 2026 18:33:45 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> This series adds a boottime tracing test framework to selftests/ftrace.
> This is based on v3 series[1] of the boot-time trace (via bootconfig)
> testing script.
> 
> [1] https://lore.kernel.org/all/178613904128.259829.16130019979800943264.stgit@devnote2/
> 
> The new run_boottime_test.sh can run tests not only for boottime trace
> but also other kernel cmdline tracing options, including persistent
> ring buffer and its backup.
> This makes it possible to easily detect regression bugs in the kernel
> boot trace options.
> 
> Here is an example of the test output.
> -----
> TAP version 13
> 1..14
> ok 1 01-kprobe
> ok 2 02-synth
> ok 3 03-eprobe
> ok 4 04-fprobe
> ok 5 05-tprobe
> ok 6 06-instance
> ok 7 cmdline-01-ftrace
> ok 8 cmdline-02-trace-event
> ok 9 cmdline-03-trace-buf-size
> ok 10 cmdline-04-trace-options
> ok 11 cmdline-05-trace-clock
> ok 12 cmdline-06-trace-instance
> ok 13 persistent-01-reserve-mem
> ok 14 persistent-02-backup-instance
> # Totals: pass:14 fail:0 xfail:0 xpass:0 skip:0 error:0
> -----

Just to understand this better. This series creates a small ramdisk and
runs qemu on a given kernel to boot in qemu and test, right?

Can you add the examples you have in the documentation patch to the cover
letter. That will market more exactly what you are doing.

-- Steve
