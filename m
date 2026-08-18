Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F5A47D920
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Aug 2026 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071278; cv=none; b=K40zm2z9cdeREzpiQBNfNcxgbcvFU9pD2Sp6XWwYZG5typsaLPgGUwb1qg6IiiVAB7wCx4TQtxg28/FUuOqLnwF0Hp36tkeBNgpBOm9ebKVe5VM4UYL+gTU9qNOy3xQhHCfUgY51MCQaOsqgGth6weOxwmx4DVcU8vQm/oQNl4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071278; c=relaxed/simple;
	bh=U/Zc/TbV88VxA0i0QQRESvuwltXvbOKWfAkbTJl3DM4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=COY+976woxF+4U7B1+85kF9mPSVOG/gThuK9K0y5gOwOYISKNKhnvneSl6VOb8uDuGmFvaZLhGIruAfnQ0/s2zZG04W6454nooaMNhO7dV1uPYcznMizvwp91aS2VSu8d5Vz9vfdMpuS8kv8U4ljhw49QaGHpgGF2BXqWIycctY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=sgEIHmyq; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="sgEIHmyq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787071275;
	bh=30lup9SBgRdpF9Pq1C2Z/x0+Cv9ITBPmLOabA308I2E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=sgEIHmyqhGOTlFnelbWCGhQzgIoVdCMViJ2vkNZttVdCqViQ+YX05rA7qClEjOIPo
	 4vaUib1vpVlkX2/8eXRzvf2s11cd2fXn0KGTY3wAXbgC8fOSZKGATWx2xwrIe8P3GM
	 QVmg8WFQf37Cp5xMjoJTCFc2lUKilotmlQzWkzaU=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4hPb7H3c8YzGpDK;
	Tue, 18 Aug 2026 16:41:15 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4hPb7H1CqczGpDG;
	Tue, 18 Aug 2026 16:41:15 +0000 (UTC)
Date: Tue, 18 Aug 2026 17:41:12 +0100
From: Bradley Morgan <include@grrlz.net>
To: Steven Rostedt <rostedt@goodmis.org>
CC: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_kprobes=3A_use_DEFINE=5FDEB?=
 =?US-ASCII?Q?UGFS=5FATTRIBUTE_for_the_enabled_knob?=
In-Reply-To: <20260818121025.187b1a1c@robin>
References: <20260818014920.23870-1-include@grrlz.net> <20260818020119.2DF141F000E9@smtp.kernel.org> <786EF401-1ECA-4ACC-BED9-764ADFAB9087@grrlz.net> <20260818121025.187b1a1c@robin>
Message-ID: <C32B508C-053C-497A-903B-E2544EB242DF@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 18 August 2026 17:10:25 BST, Steven Rostedt <rostedt@goodmis.org> wrote:
>On Tue, 18 Aug 2026 16:17:20 +0100
>Bradley Morgan <include@grrlz.net> wrote:
>
>> On 18 August 2026 03:01:18 BST, sashiko-bot@kernel.org wrote:
>> >Thank you for your contribution! Sashiko AI review found 1 potential
>> >issue(s) to consider:
>> >- [Low] The 'enabled' debugfs file is created using
>`debugfs_create_file()` instead of `debugfs_create_file_unsafe()` with a
>`DEFINE_DEBUGFS_ATTRIBUTE` struct, leading to redundant proxying and
>overhead.  
>> 
>> +akpm@linux-foundation.org 
>> 
>> I hate sashiko so damn much, best to wait for review!
>
>I found sashiko to be extremely useful. 
>
>
>> >[ ... ]
>> >  
>> >> -static const struct file_operations fops_kp = {
>> >> -	.read =         read_enabled_file_bool,
>> >> -	.write =        write_enabled_file_bool,
>> >> -	.llseek =	default_llseek,
>> >> -};
>> >> +DEFINE_DEBUGFS_ATTRIBUTE(fops_kp, kprobes_enabled_get,
>> >> +			 kprobes_enabled_set, "%llu\n");
>> >>  
>> >>  static int __init debugfs_kprobe_init(void)
>> >>  {  
>> >
>> >[Severity: Low]
>
>It is even saying this is of "low priority". That means it's more of an
>"FYI".
>
>> >Will this lead to double-proxying for the debugfs file?
>> >
>> >Since DEFINE_DEBUGFS_ATTRIBUTE natively provides debugfs_attr_read and
>> >debugfs_attr_write operations that already include debugfs_file_get()
>and
>> >debugfs_file_put() protection, passing fops_kp to debugfs_create_file()
>> >in debugfs_kprobe_init() will cause the debugfs core to wrap it again:
>> >
>> >kernel/kprobes.c:debugfs_kprobe_init() {
>> >    ...
>> >	debugfs_create_file("enabled", 0600, dir, NULL, &fops_kp);
>> >    ...
>> >}
>> >
>> >Could this use debugfs_create_file_unsafe() instead?
>
>As this isn't a critical path, I don't think we really care here if
>it's wrapped or not. But it's nice to know that it is.
>
>Anyway, I'll let others review this, but it looks fine to me.
>
>-- Steve
>
the fix is a couple of years in the making, heh
Thanks!
