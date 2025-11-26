Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF19F332ED8;
	Wed, 26 Nov 2025 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764171690; cv=none; b=gX4m555/2LhrBpIcVoj7tZJyUvKgZuye8siX5t4VQOFwWTNDSjl9EE9dMpjdWC+p2EjXIsQrJtno0qAx1XFItQsM9HdRcsWfAw95rZCIgrq3CTIGzBC6HjESPii5u/zl+6Vp7UJmWbqvrEoGmxt/MAxtOTaV2tqiURDtWv4SQrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764171690; c=relaxed/simple;
	bh=ttp3TJMDjuEJdEJ1n8SGSAzJ8t9581+zr3HZsb79zvI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tj8SvYcxGE6YQscxu5ZYhCSs8r4VhIs6Pq60pl+qnu7GySsKksMjvxIYPA7EDdJXrIlgxFMoqYFMGX1lIH47/pbfnvFiCIK3UhMqrNTgwF9cR9mrnjon9x5iM3jlv0udwcb27QlVgaTrEAhzWMOoqYdZmiScWBqt42/2NQ9B+V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 4C02213B748;
	Wed, 26 Nov 2025 15:41:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 76AB017;
	Wed, 26 Nov 2025 15:41:24 +0000 (UTC)
Date: Wed, 26 Nov 2025 10:42:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers  <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rv: Convert to use lock guard
Message-ID: <20251126104210.5696dbe9@gandalf.local.home>
In-Reply-To: <2803da35e4de12ef2ca966a69052bf228f1cd10f.camel@redhat.com>
References: <cover.1763370183.git.namcao@linutronix.de>
	<dbefeb868093c40d4b29fd6b57294a6aa011b719.1763370183.git.namcao@linutronix.de>
	<20251125145736.48c3ed9d@gandalf.local.home>
	<e4838dd91f14024222eef8e705f2b1ae7945bb80.camel@redhat.com>
	<878qft5gxk.fsf@yellow.woof>
	<2803da35e4de12ef2ca966a69052bf228f1cd10f.camel@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: bq91j98g5eywp8h6qtdg54egf3q34dd9
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 76AB017
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+lSRwMG7wioopiDdwIYGKhQGDu6Gyx51I=
X-HE-Tag: 1764171684-840721
X-HE-Meta: U2FsdGVkX19ilkEk23IPgBQXglzZzG8UosWMPO8Z0vr/BP0HdWAK92yPvLrnE6+tpijo0My2g8vTY4Wuydd8CgDRNuKludcGBu84Obac4L7FqADlabLXXpn+cg43heukxcOhJXndApmwuxyLmpaZlF1xOkPZcmBkOx8vZ4SEQyfBQcvYL3GyK57ASPrJPA83+SVYtwlJ8D3BPyOXyYN6ibe3lOHsc70AVkJSvKlDvTx9cUkhXirDWWfzRQkKh4yH/qNbzPWE+CU/05wmFYTy+BTcly/JN76Pu6+A2xZEFZKLaS9ukuB7OQVgOPI7p5t3wDGegR/iGA5F6gMSIbaf+W81gLjKdeKq

On Wed, 26 Nov 2025 10:33:51 +0100
Gabriele Monaco <gmonaco@redhat.com> wrote:

> > > No biggy, but I wonder if this would look better as:
> > > 
> > > 		return retval ? : count;  
> > 
> > Unless you really prefer it this way, I would rather not. The first time
> > I saw this syntax, it confused the hell out of me. Took me some time
> > scratching my head until I figured out that it is a GNU extension.
> > 
> > I prefer to stay with the C standard unless there is major benefit not
> > to.  
> 
> To be fair, I find it a bit obscure as well, although it's frequently used
> within the kernel.
> 
> Let's not change it then.

As I said, "No biggy". I personally like that notation better. But that's
my own personal choice. I won't push that on other ;-)

-- Steve
