Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD29723C50F;
	Thu, 12 Jun 2025 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749735262; cv=none; b=YCgCCw3n2ZDQA1dJ05ctn5kW6guznSLbWbPflDFhoWQt8CTHS0MZ8pmpOxGk/+8s6ilRcL/k+tiHZioBza5PMmB7WOfGEBZre04t9AapJkmHSXmsrk55V64YuGUBRGK4CDVqUt3Dj+QurvTPZTljae6AJwuze12xB2qH/PeymMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749735262; c=relaxed/simple;
	bh=4nOwCOzoXhUV4HhV7lS40+s4CsIgC1yHr144wW5EtNU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mELrkb/2Sn4nvUDijJb4FCr0R1g8CNPzo+a7J/um5v5WoDFDm9r2wnhGzlB6VIzR2UH0wao/oCm8YOtZQGnd5WoEb39RdRjbNzg2xnZPRPl17XCPX6PaTMVVGWXggoBR3Umd/IvckHphKaGA+65tdYxCnj+8X8+vQ9SHJgR5J+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id D3CD21D80A4;
	Thu, 12 Jun 2025 13:34:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 5EA1A20024;
	Thu, 12 Jun 2025 13:34:09 +0000 (UTC)
Date: Thu, 12 Jun 2025 09:34:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?="
 <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen
 <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, Christian
 Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, Suren
 Baghdasaryan <surenb@google.com>
Subject: [PATCH] binder: Remove unused binder lock events
Message-ID: <20250612093408.3b7320fa@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ot9rj6czg8cze1crshkbh1qwzchi3dxw
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5EA1A20024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+MNXt9Axg3pIFCzE+kX+CehiHv8MZXeeY=
X-HE-Tag: 1749735249-369024
X-HE-Meta: U2FsdGVkX182ghxfYEu+xq8bdt4k9kvRIUjtUZhhIGS5hHr2ZSDSBhkRvW2pzKXgtTzkTRrSauJVb8PeZEFwaKMqFcu/njaj3idaP9x3zkryVavFRdDYzaAw6QS8Nto3Po2zA+0WxD5XDJ7jscxy5OERCXctQJAlMyqRSpW3lwtxmbKNOYGqxOfbcGCchKlGqAI8OXcqe26OevG5BGd4kHzoDmxyRUdZIkTAC1SRr3RVE8QrZU9hKQUfy68IuqHRoh7L/9dY4ZWAmV9XZjwaLisGh01uJ2OdGkWnsjvNo5nl1eV6s8imo/0FamDVZvexpBGe2RBghhAsus5MiOL/n98yNxTTsXk0o/LBB0LS7CRqS8n/NZpRqr3XNC+odY8g

From: Steven Rostedt <rostedt@goodmis.org>

Trace events can take up to 5K each when they are defined, regardless if
they are used or not. The binder lock events: binder_lock, binder_locked
and binder_unlock are no longer used.

Remove them.

Fixes: a60b890f607d ("binder: remove global binder lock")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Note, I will be adding code soon that will make unused events cause a warning.

 drivers/android/binder_trace.h | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/android/binder_trace.h b/drivers/android/binder_trace.h
index 16de1b9e72f7..97a78e5623db 100644
--- a/drivers/android/binder_trace.h
+++ b/drivers/android/binder_trace.h
@@ -34,27 +34,6 @@ TRACE_EVENT(binder_ioctl,
 	TP_printk("cmd=0x%x arg=0x%lx", __entry->cmd, __entry->arg)
 );
 
-DECLARE_EVENT_CLASS(binder_lock_class,
-	TP_PROTO(const char *tag),
-	TP_ARGS(tag),
-	TP_STRUCT__entry(
-		__field(const char *, tag)
-	),
-	TP_fast_assign(
-		__entry->tag = tag;
-	),
-	TP_printk("tag=%s", __entry->tag)
-);
-
-#define DEFINE_BINDER_LOCK_EVENT(name)	\
-DEFINE_EVENT(binder_lock_class, name,	\
-	TP_PROTO(const char *func), \
-	TP_ARGS(func))
-
-DEFINE_BINDER_LOCK_EVENT(binder_lock);
-DEFINE_BINDER_LOCK_EVENT(binder_locked);
-DEFINE_BINDER_LOCK_EVENT(binder_unlock);
-
 DECLARE_EVENT_CLASS(binder_function_return_class,
 	TP_PROTO(int ret),
 	TP_ARGS(ret),
-- 
2.47.2

