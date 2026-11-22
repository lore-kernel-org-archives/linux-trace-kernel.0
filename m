Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795330096;
	b=2S62PXiAA4pjPSL0wniGmmlB1O/1nuzlmv4qAb6YQAEynNFi1hkfs95DSEmGUG7E3d+q
	 NsUkZ0ATUtO1V4SimizHhVSXW3OZZ4teLLBxuYL+/EamgCOaqoVpjTDj1RCiCAf8pP+6E
	 5M3ycLLijJeiljFJSqBxgTvGXkR4hHx0JM/gABrgre0g1ARm4sRtPM8bOdvlWqqN/nUYX
	 SoCapZi6Xwhjqu+1oPFpRPjjj8vXtcIr1l76Ud5WI5146dfX5n2aIstRdFfPhmu3VfF8g
	 ZCJE//OQ/3aFxikCoOj5QcfndojdJ7K4+UMTHOZjAglx7+UTcYq+9Sxi7Uk5QbWXvvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795330096;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jU3Rjtt2TYhW+JT4o07C8vNvEkhSijnYRwg9Z6lTOJg=;
	b=ui/x5UZwwPznfG3gZ85AGbZt6fJlF30hQ8X+H7x2jtuqqdfkjewbWQknz0mpO9RRzhx+
	 Xb+v7Nu2J4LLNhlnnMb/vSfku4Qz/+4Iujhw/hsn2392RAYyYVrljikwRpODCPDJiMeAT
	 xx22ds2R4caUIIBy0IpXpzVfqxyot3NtVD71eTw6Egd+X+CIp3VT0JbKpGimK9uWRNhl7
	 /RLe3XH2FXPzOc+lww0tCPzyNY7aYNHt4Did2ph/MdC+lnIpOoWkZF4WGIN3MaVu/lvAm
	 VGBFS1F/TbVVwt5EBmxLKo2JoG8drGYibJfMZa9gmKn3XUca4lGSakN+oT6nYCjmfUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eLqH7HO7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067DF606A320;
	Sun, 22 Nov 2026 06:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eLqH7HO7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AACF1F000C0;
	Sun, 22 Nov 2026 06:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795330095;
	bh=jU3Rjtt2TYhW+JT4o07C8vNvEkhSijnYRwg9Z6lTOJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eLqH7HO780EC7N28MjNRlydabDuV03UbAffoK1z0B86lyHGSxY5Owsr8DpVuQtX9O
	 h9iyYiaiLMiupF6p3VCrMY3O0uW4OqScKlPRQZ+HM8dUounWZqWTHUW4384iXEc1uW
	 /sGZ04QsjmnGZLLrD8RrQ5d4dSVHj/pCSYhia8pczOlDV9aWI8VUvrDioTbiPngs4c
	 KPgrqOI7LAAzQEPfIqLWHTv+LHdj4ZzSHUDdlOJMPIPs3gYSSwcl14CN2cQExOFZVT
	 mI/LSNCTkcNZFIr1zgj4EnZ0nFDHiFRS94USUVb2cJql0ZFMvfBMAWJSB2bwgp1fTc
	 YJWBT7F4jUFvg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: syzbot <syzbot+1faa12be48036b80e416@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [trace?] KCSAN: data-race in __trace_trigger_soft_disabled / apply_subsystem_event_filter
Date: Sun, 22 Nov 2026 15:48:12 +0900
Message-ID: <undine-1795330092274022531-b71577926e29530e@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <6b0234dc.44b41460.34b83f.0019.GAE@google.com>
References: <6b0234dc.44b41460.34b83f.0019.GAE@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Sat, 21 Nov 2026 16:18:36 -0800, syzbot <syzbot+1faa12be48036b80e416@syzkaller.appspotmail.com> wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d0f871bfb831 Merge tag 'arm64-fixes' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12708a03580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=886d2ddd2d6b664e
> dashboard link: https://syzkaller.appspot.com/bug?extid=1faa12be48036b80e416
> compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/018edb90159d/disk-d0f871bf.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b27112368dea/vmlinux-d0f871bf.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1f2c7b502c76/bzImage-d0f871bf.xz
> 
> AI-generated root cause summary:
> `filter_disable()` (and its counterpart `event_set_filtered_flag()`) in
> `kernel/trace/trace_events_filter.c` updates `struct trace_event_file::flags`
> using non-atomic read-modify-write operations (`file->flags &=
> ~EVENT_FILE_FL_FILTERED`) instead of atomic bit operations
> (`test_and_clear_bit()`/`test_and_set_bit()`). Meanwhile, tracepoint handlers
> such as `trace_trigger_soft_disabled()` and `__trace_trigger_soft_disabled()`
> read `file->flags` locklessly without `READ_ONCE()`. Writing a failing subsystem
> filter via `subsystem_filter_write()` triggers `filter_disable()` while
> `sched_switch` concurrently executes `__trace_trigger_soft_disabled()` on
> another CPU, causing a KCSAN data race on `file->flags`.

Hmm, this means we need to update all code which accessing `file->flags`.
The point about using `READ_ONCE()` is correct, as the trigger must be able
to operate in parallel without acquiring a lock.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
