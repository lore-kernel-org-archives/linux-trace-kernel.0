Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706E3BA45;
	Wed, 19 Feb 2025 00:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739924666; cv=none; b=dtybvVTZL52BsCVaYfN2g5KYXZDr331FTw6Drz5UFkA6/qNDqy+KNTwPHMqxtu+YQPcGgongS7mVehVlvqhBvXcdvptrIQE08wl4L1bVhFDRXQPdDR2oKadetjeFUoZM4rcCC/giM2Vpib9ugHNsumtzP9CzEwq+hNGMnZO4AY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739924666; c=relaxed/simple;
	bh=v+G6XQjKH8mwQQ9LTsWzSc9ufj1uf31ots88a2yaIdU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RngZzjcAH0Kre/oWyFqAyjPvCTBrFOpqDJxN4rIPAmoVuu7rsMrCo4lLj8Es2pHb6Elb1tmy0ULsQQqwQ4ienvpjjPwNUOENpXpaXRPx8OhssQRSAkkS7jI8I9HFxSYnL9pk3p73lP80yKuraXE4Paed6zGET2s/U/EVCm420gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D314C4CEE2;
	Wed, 19 Feb 2025 00:24:24 +0000 (UTC)
Date: Tue, 18 Feb 2025 19:24:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami
 Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-modules@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH 5/8] module: Add module_for_each_mod() function
Message-ID: <20250218192446.1269e461@gandalf.local.home>
In-Reply-To: <Z7T50DxEL7NYkr8H@bombadil.infradead.org>
References: <20250205225031.799739376@goodmis.org>
	<20250205225103.760856859@goodmis.org>
	<20250206142817.91853f475c681bc2ef7ca962@kernel.org>
	<20250206102720.0fd57129@gandalf.local.home>
	<20250214173017.07b0b250@gandalf.local.home>
	<Z7T50DxEL7NYkr8H@bombadil.infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 13:21:20 -0800
Luis Chamberlain <mcgrof@kernel.org> wrote:

> The patch is not OK, you're looking at old code, look at
> modules-next and as Petr suggested look at Sebastian's recently
> merged work.
> 
> git remote add korg-modules git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git

Would this be OK?

I have this on v6.14-rc3, and it doesn't cause any conflicts when I merge
it with modules-next, and it builds fine.

-- Steve

diff --git a/include/linux/module.h b/include/linux/module.h
index 30e5b19bafa9..9a71dd2cb11f 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -782,6 +782,8 @@ static inline void *module_writable_address(struct module *mod, void *loc)
 	return __module_writable_address(mod, loc);
 }
 
+void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data);
+
 #else /* !CONFIG_MODULES... */
 
 static inline struct module *__module_address(unsigned long addr)
@@ -894,6 +896,10 @@ static inline void *module_writable_address(struct module *mod, void *loc)
 {
 	return loc;
 }
+
+static inline void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data)
+{
+}
 #endif /* CONFIG_MODULES */
 
 #ifdef CONFIG_SYSFS
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 1fb9ad289a6f..1bd4e3b7098a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3809,6 +3809,19 @@ bool is_module_text_address(unsigned long addr)
 	return ret;
 }
 
+void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data)
+{
+	struct module *mod;
+
+	guard(rcu)();
+	list_for_each_entry_rcu(mod, &modules, list) {
+		if (mod->state == MODULE_STATE_UNFORMED)
+			continue;
+		if (func(mod, data))
+			break;
+	}
+}
+
 /**
  * __module_text_address() - get the module whose code contains an address.
  * @addr: the address.
