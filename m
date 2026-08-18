Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE4D3A6EF1
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Aug 2026 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066253; cv=none; b=NSPqe6Y97DYmA/JUGoMHGYpPUiQRv22/reZwIGXKrdvDu2du/BtEZXPkbp2JYUXgXcldXY9O6dUwtmaSFKHbTnw1ephBiRYryLxBU8sd6Nu4Zq4aLifV6Fv7mu1+0ADno5VMElThfHZeSGgH9uyI7r5PXaSwMmxxh4bbS88+GtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066253; c=relaxed/simple;
	bh=IAFOleP9PKZrqVNHvILegTCgb2/Y9h07y+JQuxY4Wnk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=bJ5awD8g5OgjfotYU2pN24EII7CJR52hUQO2HxhR6gAN4Voc8JBrXSECIlXttyIJJ7Swpynu0/0MIw36z2YmP+d415dhkzHAZKG3OYRoQZyTIvAbDz2ntf3WuUU18AfN9/DyUB27IdAcm2UABIvKuT5EjXHey4lnu6NAIzEGFeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=Rfjy0M/u; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="Rfjy0M/u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787066241;
	bh=4pgB6nTt+K8CIebFqRQUJykNy2kI7bCZa71ZlN3FIBs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Rfjy0M/uoJu2Sui7u+ve8khcxnyNywQUHebzBcNMtIcY0w9wrFg4Qca/ynJWAM2gB
	 PnSiACJ1Sv6HGnOIL3y2HN+LmXAFpoSgYihVILbf4KGDe2J39lKuMBSWtfg6WCsmqA
	 duJjaAtKfGM4JBBpfYb88U+oSGkbr0UWw2y++1a4=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4hPYGT0jNRz6vHk;
	Tue, 18 Aug 2026 15:17:21 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hPYGS561Gz4y6W;
	Tue, 18 Aug 2026 15:17:20 +0000 (UTC)
Date: Tue, 18 Aug 2026 16:17:20 +0100
From: Bradley Morgan <include@grrlz.net>
To: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org
CC: linux-trace-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_kprobes=3A_use_DEFINE=5FDEB?=
 =?US-ASCII?Q?UGFS=5FATTRIBUTE_for_the_enabled_knob?=
In-Reply-To: <20260818020119.2DF141F000E9@smtp.kernel.org>
References: <20260818014920.23870-1-include@grrlz.net> <20260818020119.2DF141F000E9@smtp.kernel.org>
Message-ID: <786EF401-1ECA-4ACC-BED9-764ADFAB9087@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 18 August 2026 03:01:18 BST, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 1 potential
>issue(s) to consider:
>- [Low] The 'enabled' debugfs file is created using `debugfs_create_file()` instead of `debugfs_create_file_unsafe()` with a `DEFINE_DEBUGFS_ATTRIBUTE` struct, leading to redundant proxying and overhead.

+akpm@linux-foundation.org 

I hate sashiko so damn much, best to wait for review!

>--
>
>--- Patch [1]: [PATCH] kprobes: use DEFINE_DEBUGFS_ATTRIBUTE for the enabled knob ---
>commit f5babbd146ccf4194f28506d04f5cbfb2c40150a
>Author: Bradley Morgan <include@grrlz.net>
>
>    kprobes: use DEFINE_DEBUGFS_ATTRIBUTE for the enabled knob
>
>This commit replaces the custom read/write handlers for the debugfs
>enabled
>file with the standard DEFINE_DEBUGFS_ATTRIBUTE macro. It simplifies the
>implementation and accepts integer inputs rather than characters.
>
>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>> index ca9d834d0b843..10bcc2a0926a6 100644
>> --- a/kernel/kprobes.c
>> +++ b/kernel/kprobes.c
>> @@ -2962,47 +2962,22 @@ static int disarm_all_kprobes(void)
>
>[ ... ]
>
>> -static const struct file_operations fops_kp = {
>> -	.read =         read_enabled_file_bool,
>> -	.write =        write_enabled_file_bool,
>> -	.llseek =	default_llseek,
>> -};
>> +DEFINE_DEBUGFS_ATTRIBUTE(fops_kp, kprobes_enabled_get,
>> +			 kprobes_enabled_set, "%llu\n");
>>  
>>  static int __init debugfs_kprobe_init(void)
>>  {
>
>[Severity: Low]
>Will this lead to double-proxying for the debugfs file?
>
>Since DEFINE_DEBUGFS_ATTRIBUTE natively provides debugfs_attr_read and
>debugfs_attr_write operations that already include debugfs_file_get() and
>debugfs_file_put() protection, passing fops_kp to debugfs_create_file()
>in debugfs_kprobe_init() will cause the debugfs core to wrap it again:
>
>kernel/kprobes.c:debugfs_kprobe_init() {
>    ...
>	debugfs_create_file("enabled", 0600, dir, NULL, &fops_kp);
>    ...
>}
>
>Could this use debugfs_create_file_unsafe() instead?
>
>

Thanks!
