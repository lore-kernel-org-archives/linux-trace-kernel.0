Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311A12DB7BD;
	Thu, 23 Jul 2026 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816242; cv=none; b=U+uqrlqdoUYKCRry2FbhQdbU47x1fmqfEwvZLXNAih2dPWZyMAWQLNqwQRbfI0lkn8D6MkVk8FMeoh7BO47Sik94/wDPs3KjpDHsHaW1aPf6bK0xVPXSv1Y9PH6mJW4RdF6rDn0iON3iCSvJuqLFJm9uBczlLTP/4Toq2pFoOXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816242; c=relaxed/simple;
	bh=qa6rCC4HxRlNJdgthiUWGxrTKVg1sstP6lAUL9v3uj8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qmZBS+Mo7ULk/ZU+jTeMYgZfDv6XVsZuDuLpTvJjqaUZt46yemBnLRNZlOWov9rc0PcboK6CCWOyNp0PLtHkNK2NWMGN9iGPQI20h8HgGRn3FpRk/4V88VN6hyp0ELpFhwh0sWAoNUkCAIkzS9Cc1OU7xcY7aYajnRq0COCIF+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id A9D2F404DB;
	Thu, 23 Jul 2026 14:17:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 904EE20030;
	Thu, 23 Jul 2026 14:17:12 +0000 (UTC)
Date: Thu, 23 Jul 2026 10:17:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: liubaolin <liubaolin12138@163.com>
Cc: almaz.alexandrovich@paragon-software.com, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 ntfs3@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 liubaolin12138@gmail.com, Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v1 v1 2/7] ntfs3: add namei tracepoints
Message-ID: <20260723101735.377f355c@gandalf.local.home>
In-Reply-To: <a36a7376-d750-4f07-a626-e916fe77ff77@163.com>
References: <20260717032248.3318208-1-liubaolin12138@163.com>
	<20260717032248.3318208-3-liubaolin12138@163.com>
	<20260721170952.26f79352@gandalf.local.home>
	<a36a7376-d750-4f07-a626-e916fe77ff77@163.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 904EE20030
X-Stat-Signature: wuxrzsxckx4zuqi9669r9b87niqmxn9i
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18iCnUxKdK3YKs9RUdak94ljBQU2YB4CYc=
X-HE-Tag: 1784816232-640118
X-HE-Meta: U2FsdGVkX1+UWEREyCHg2Gf8hGM7/IaJ7o0ICG5ARzq45wW0MOtBtv//cm/quaegznHbYYWuR/EkcLR7Cz3TfjfTanCZFqd5Z0VQuxcT5eDQiAQrpz2KlmwyVsEEZVSU9occKUxQbMOC5moyyopyyc5gGSy/92LMMk16KzDeJtBegGz8Y3reOq3gCONmP47BjRUs4Ve4dNrndML3IZ5SOeUw5LQMO7a1wDDAu7iUUTY8Tt+U8Wfu4AZbsSPtDdl/HK++aykTtW89bntQIyqhDV2Cb0DRTI8pfVWpMhwk9vMqZH0nG0hRgKqp8AqhgkvouaybdkNri2XXb9KuZQmXBgk9+J7rvXMf

On Thu, 23 Jul 2026 17:30:33 +0800
liubaolin <liubaolin12138@163.com> wrote:

> Dear Steve,
>     dentry->d_name.len is the qstr length and does not include the 
> trailing NUL, so it corresponds to strlen(dentry->d_name.name), rather 
> than strlen(dentry->d_name.name) + 1.

But it is still tightly coupled with the actual length of the name.

> If you think the extra name_len field here is unnecessary, I can submit 
> a v2 patch to drop it. Looking forward to your feedback.

I'm wondering what the purpose of it is for. The length of the string is
also stored in part of the meta data of the event which can be retrieved
via:

  __get_dynnamic_array_len(name)

Although that will be strlen(name) + 1.

-- Steve
