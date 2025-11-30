Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6A821E098;
	Sun, 30 Nov 2025 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764534859; cv=none; b=DrvUJGNpFfo33mwmkYGjA+zf+D0/q6B46/QSVoj8FTCZuEkSh/T6DLDTbR9SdazLL6Gm6Rbqk4UP3s04TmLZCC22ZGVLLnRyoIFOZgS5MNUOW9I+ZxKcZiidkyDKm0G8N42oezZX1moAnpWbqMYfH8AQlT+SnBIVQ1QtiRvlrCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764534859; c=relaxed/simple;
	bh=o8pMdand1kMcsEfLgm/Lp1MLVevxcB/3b/ZbDinE5nE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZfMu+NkhXtJYdeopy3mbNqpZPCkAr3stnUFCQ1wCa1fiQLxV9pvkavziy5T0i8SmIGL3lmSkO5DenuPiTGXH8b39ySPenGSZLC1QXvvpe4zi5PijHATxyR8YcR4eEbvm+RxB0aHdU7cvT2EjQc3vheiVvkJ7OwRSaplfxBm4Ly8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 71DB6BDD17;
	Sun, 30 Nov 2025 20:34:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id D6E5230;
	Sun, 30 Nov 2025 20:34:03 +0000 (UTC)
Date: Sun, 30 Nov 2025 15:34:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, Petr Pavlu
 <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tracing: move tracing declarations from kernel.h to
 a dedicated header
Message-ID: <20251130153402.5f9b1ef3@robin>
In-Reply-To: <20251129195304.204082-4-yury.norov@gmail.com>
References: <20251129195304.204082-1-yury.norov@gmail.com>
	<20251129195304.204082-4-yury.norov@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: D6E5230
X-Stat-Signature: j5tehdexpqdg4rdr7trzjy8mz376az96
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/52eviERCbV/E3aAX0dh7AzDBtVKG6APA=
X-HE-Tag: 1764534843-208077
X-HE-Meta: U2FsdGVkX1+um0kCBvU8lgBToDE6VckRZedmUKoJyyVyXXbYM6CY4Q0+FXUXxghtB5cOP41euWUq6vuvE5C8k1+4FjdMi07N0aWN7cDoE5BpKN0ZdmBMchnnYfinPD4fUGnaM/yXvWxcZyY8D9Ri9h5L/866dJsvLdy8sA6R19N47pwAHrV3oZ2TkO6zoIHyIjEsMJdXojdVkD6V8d5qo8rHCrOpz67CIsC0o18yTos3tfd7iIKP5+haPSBSJj4RpoXgzKPPc/77XTYcRPBKxwNKMZN/ltIvLLi03m7/lU7VsQAtvmqcQWNhQCxG1dK+JznQac1vagDC99Tz0fC+XE0IkL/R8/66ndPFUH7ddbEYNXrDedJiUcezulMMOEqh+U6WIBCTkOhvf5S31Ec66A==

On Sat, 29 Nov 2025 14:53:02 -0500
"Yury Norov (NVIDIA)" <yury.norov@gmail.com> wrote:

> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -27,6 +27,7 @@
>  #include <linux/math.h>
>  #include <linux/minmax.h>
>  #include <linux/typecheck.h>
> +#include <linux/tracing.h>
>  #include <linux/panic.h>
>  #include <linux/printk.h>
>  #include <linux/build_bug.h>

I'm fine with this as long as it's available as much as printk is.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
