Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE37A22AE7B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Jan 2025 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736772085; cv=none; b=aLIVf5ybZEeZRFWfnSMBc59jrfCL00detbgYORtjNOqhgguaILVvywwYaNLtbB99bI2RCYR29igynAzLgBoKbuIdlVuS7l3Z0d06rMfKG3QuzC0A7AszcM74iAPfx8vH1d2FDpGkQIvBF+yqPH7nkLKUCuLXXM0e99axFerUDOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736772085; c=relaxed/simple;
	bh=N5gnchFMO7c1uZZ73wF9xmZnBLRT5LdVgTMxzZS6Eco=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VaYRQ1cqYwXwWBZcZBOEokZyXJrJTfdzDaPeD9LWm+g0lYYgFN+DOX61VZju4kPLdKrEZTrrE31WPaJXrEBzoCK1HNonPj2UsHLKSNeioikqKstMBfV6MqKtTk6NhpLIdohZxZLLnAL2vE24r4+mxWg2ZAAidzx+uW1hp9CDLRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a817e4aa67so33600375ab.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Jan 2025 04:41:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736772082; x=1737376882;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QcOtMRgGm5MUBc+oytNDvsNlZGoOxWbXkkUq/+Kvmf8=;
        b=kLN9wu14IHdn5CYovSBu8FwmIzQzqYBOEMkIAPYXahS090gVlt/N/HABLflbipaRfI
         b1D/M1KrNxBDX3YZUB6WnEHRTVtWGxYe3xabeZMtsFWhYOe0KBjJUNSrI5T7PawuA4m/
         8y1WCq3c3Ax0gIGXUOKahj6axVu46fT7jMS+LhTaHjFTXfLKT+4FXU/bE41szYRv8UfE
         isDJxEOJ52ru7lrzfKckOUVxI4gKZmfFJEvShjfUoAjOiNRb3lrpBNi7pxvT1tygApy+
         pUbs49J1jyovgmgs2DOrzOr0wxYt7S3j4UngJRuKmYjaur9JhblBrhCFx14z9FvlGTNa
         Ds3g==
X-Forwarded-Encrypted: i=1; AJvYcCVTRtqzPpPhERbnk2fxLNZztGOwtwTkkPpbumZ8x38OK8VXr8NZfAzYCvtpN73+2rKavEvasEMCD5W9YZXW8QQAx90=@vger.kernel.org
X-Gm-Message-State: AOJu0YxihJD/5tCh9A5RX3tHYUCUFpvBa5q20gvG2YZ5X3ZJB/mYdsTX
	9MXe8T0zzLlGgSaFvVzYv7Ek/Hb/hAJ14G+oxfZlWSy8nwW7nYMHOIZ+EQ5yVF59ccmFcTtUigH
	aiAkw3NR13vwWG9WZWh3AuhcPT4u1+J0uHTYlZhqS4VYGQIav1dhH/o4=
X-Google-Smtp-Source: AGHT+IHitu8exlbfI9GEO/fi0EN11XV8dT/ihyYZ0NFGc77xZxYUeghW4fgeZwuMuc+gw4q+Uc9Y7G13IzVKPq81j/YZ5W47Fg/j
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3891:b0:3bc:be0f:edcd with SMTP id
 e9e14a558f8ab-3ce3a96da56mr126882305ab.11.1736772082735; Mon, 13 Jan 2025
 04:41:22 -0800 (PST)
Date: Mon, 13 Jan 2025 04:41:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678509f2.050a0220.216c54.0054.GAE@google.com>
Subject: [syzbot] Monthly trace report (Jan 2025)
From: syzbot <syzbot+list25722e017155043d4db9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 1 new issues were detected and 2 were fixed.
In total, 17 issues are still open and 41 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2743    Yes   possible deadlock in blk_trace_setup
                  https://syzkaller.appspot.com/bug?extid=0d8542c90a512dc95185
<2> 1434    Yes   WARNING in format_decode (3)
                  https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c
<3> 94      Yes   WARNING in bpf_get_stack_raw_tp
                  https://syzkaller.appspot.com/bug?extid=ce35de20ed6652f60652
<4> 71      Yes   WARNING: locking bug in __lock_task_sighand
                  https://syzkaller.appspot.com/bug?extid=97da3d7e0112d59971de
<5> 17      Yes   WARNING in tracing_buffers_mmap_close
                  https://syzkaller.appspot.com/bug?extid=ddc001b92c083dbf2b97
<6> 15      Yes   WARNING in get_probe_ref
                  https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160
<7> 5       Yes   WARNING in tracepoint_probe_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=a1d25e53cd4a10f7f2d3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
