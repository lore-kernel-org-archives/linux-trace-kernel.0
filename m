Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7DF18B484
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410576; cv=none; b=NOW56ZcdpjOsG2ZU8/YsI+MXAgJoEdeBC2EKf1rpKVGD7quJzlUdfvkq1ckVktnYVHHxWJHZ5GwwawrUsGUeiJmSGO1ubqR8i/6DCYWM6dAfEmbtzkEPTIPnVvdDyIGw8gyD56hJQGcab+EiqPri8yRFD/iXSMLKM7y82qGLKYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410576; c=relaxed/simple;
	bh=KA03db2Q7Bmc8LTEwFfTxiDDccSBkDh4Mxm0Z7Yphys=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aGVTBPCGNmE/jhRtZzrAOYEDXhr4gt0Hll7iN3msh7nJXJqaeHh3sYi46gqWKYvVy4/uzamkiLLFEZbIq+op68E2gb5dgp1+iNpPmZC0KR8nvcGqW/DQ1IN6bONWh6g0070or0otLQ97vrA2Uxm47pcsl46bhzd0V9ZBRuMdAuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZLf+sTN8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLf+sTN8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740410573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=KA03db2Q7Bmc8LTEwFfTxiDDccSBkDh4Mxm0Z7Yphys=;
	b=ZLf+sTN8+ZXgD06/uZa1eOWawp/QlknqFljnfXOJSoYB1+ioYhB+f8M1zpgpZ/I7PlvRwx
	GaobxMNl1Bg292xogGmXviWDp7NQJ80gBJwC3oNUk2lH0wG/Xldugi6nQpmK/sKw1WODpZ
	cxOJ+Md9n9OCiAmNZhNIldjtGEekemA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-vJUJqGgwMJi4euzWOhMlzw-1; Mon, 24 Feb 2025 10:22:52 -0500
X-MC-Unique: vJUJqGgwMJi4euzWOhMlzw-1
X-Mimecast-MFC-AGG-ID: vJUJqGgwMJi4euzWOhMlzw_1740410571
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-abb4d3ef1a7so386203566b.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Feb 2025 07:22:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740410571; x=1741015371;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KA03db2Q7Bmc8LTEwFfTxiDDccSBkDh4Mxm0Z7Yphys=;
        b=OchLK26zEzexl62cnqk7TH4OtxnTuyNZ7mYkAxrzoVeQtbLaiLvK9s7EodOR1Umi92
         nkM6/ng33aHYKp5id1vDhg+Egm1sTDScGxhcY+LT4wZBVxlRMGtAlBmbuNiVLhifg6AZ
         j2/WoLjH0G13V9JXqgCUq9foSApxME5gQ1H2CRqDOX+Zch+GquAb/HJ9HKVjmeM2r9ZV
         fDLM9kh+/kAEmxje2BrZ38nnDqZUy//hVfjQTEcINMKDtD9t5g/ZZD8ZGUqRWHZy4FtH
         AQHDs1EV2HaHTTR1EB0nW6kO62vYz3PjInrQ39siCpvblNGUoIVlGVvKgWRNenF368ST
         gM+g==
X-Gm-Message-State: AOJu0Yw3GMngGkpVoj7PyOOLXWJqYAZ2RcnEcf4n9V/qapNW2RaYZr0L
	3+qj07Q36TxGGl+Zl+aWAcTXYjtSZNv2uFOs1k8/pyhrA96wQEoUic64HaGlH7gmeeQqLxuNejH
	jqp5HyAR2ajhaE+AcOlE9j0UCQxKq8nHUFO2I+zBx+BUkco6K36fX/0MtS4XlCAObuhqb4OlbGj
	zA2KI/43EeWDlnLX48YakBtRCa2rIbaT1sVO7p9e/PTVHuG1C/E/BNOQs=
X-Gm-Gg: ASbGncvoa10SRq3QKTV7RERUEfWDdj94433insywOWiBZP4gy7h+7e1PZWBwS/8CEMI
	e9CSXR51QXHztFOkZbQWijxHK9t/ykkJozDW6GKHyHHqTg2qjzljXMCpzFkF+iKEeTWkaH+0q4u
	3Eo33VIgl8hsfbJUQLUthrxxzFhaw=
X-Received: by 2002:a17:907:6ea2:b0:abb:bcef:837c with SMTP id a640c23a62f3a-abc09e47232mr1275776766b.56.1740410570890;
        Mon, 24 Feb 2025 07:22:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBo6s8cUiAqNVZm4nJopUm/elE2Aq6N61eGyZLrPKP2pVrQSWw1dK8qw/4PCpKABglA5S89W6ODLXX+NDpmlQ=
X-Received: by 2002:a17:907:6ea2:b0:abb:bcef:837c with SMTP id
 a640c23a62f3a-abc09e47232mr1275773466b.56.1740410570450; Mon, 24 Feb 2025
 07:22:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 24 Feb 2025 16:22:39 +0100
X-Gm-Features: AWEUYZlP3Wh5a4SlvjJ5cLB44e_lexr3gB5QopvTOz-dW8HAy8T83mH9jizYL8A
Message-ID: <CAP4=nvTsxjckSBTz=Oe_UYh8keD9_sZC4i++4h72mJLic4_W4A@mail.gmail.com>
Subject: [BUG] Crash on named histogram trigger with invalid onmax variable
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oRM8Enz4evMXb6VrNjWiWK2quTvYZv-a2QNt4MFOzhI_1740410571
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Dear maintainers and linux-trace-kernel,

I stumbled upon a bug in the histogram trigger implementation, where a
named histogram trigger with invalid onmax variable does not get
unregistered properly in the error path, and a subsequent access to
the same trigger file leads to kernel panic.

The issue reproduces on 6.14.0-rc4 with these commands (works with any
trace event):

$ cd /sys/kernel/tracing/events/rcu/rcu_callback
$ echo 'hist:name=bad:keys=common_pid:onmax(bogus).save(common_pid)' > trigger
bash: echo: write error: Invalid argument
$ echo 'hist:name=bad:keys=common_pid' > trigger

which leads to the panic:

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 3 UID: 0 PID: 2187 Comm: hist_panic_repr Kdump: loaded Not
tainted 6.14.0-rc4 #10
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-3.fc41
04/01/2014
RIP: 0010:strcmp+0x10/0x30
...
Call Trace:
 <TASK>
 ? __die+0x24/0x70
 ? page_fault_oops+0x75/0x170
 ? exc_page_fault+0x70/0x160
 ? asm_exc_page_fault+0x26/0x30
 ? strcmp+0x10/0x30
 find_named_trigger+0x4a/0x70
 hist_register_trigger+0x3e/0x320
 event_hist_trigger_parse+0x520/0xa80
 trigger_process_regex+0xbc/0x110
 event_trigger_write+0x79/0xe0
 vfs_write+0xf7/0x420
 ? do_syscall_64+0x89/0x160
 ? syscall_exit_to_user_mode_prepare+0x154/0x190
 ksys_write+0x66/0xe0
 do_syscall_64+0x7d/0x160
 ? syscall_exit_to_user_mode_prepare+0x154/0x190
 ? syscall_exit_to_user_mode+0x32/0x1b0
 ? filp_flush+0x72/0x80
 ? filp_close+0x1f/0x30
 ? do_dup2+0xae/0x150
 ? ksys_dup3+0x65/0xf0
 ? syscall_exit_to_user_mode_prepare+0x154/0x190
 ? syscall_exit_to_user_mode+0x32/0x1b0
 ? clear_bhb_loop+0x25/0x80
 ? clear_bhb_loop+0x25/0x80
 ? clear_bhb_loop+0x25/0x80
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Further investigation revealed that hist_unregister_trigger called in
the out_unreg path in event_hist_trigger_parse (which, by the way,
accidentally passes glob+1 instead of glob; it doesn't matter only
because it is unused) does not find the trigger, and, thus, does not
free it and remove it from the named_triggers list.

Subsequent calls to find_named_trigger then finds the freed
hist_trigger_data, tries to compare against it for name and crashes
the kernel.

I'm not familiar with the trigger implementation. Do you have any
ideas on why the hist_unregister_trigger fails and/or a fix?

Thank you.

Tomas

