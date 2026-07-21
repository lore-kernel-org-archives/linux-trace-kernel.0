Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF3A35201C;
	Tue, 21 Jul 2026 21:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784668179; cv=none; b=gAufiLOjoYM0mAmIuRbuQuN0KBAlW7TnlPE2v2wdkQ4/xMKGVMAjFi3Gl6YNqRTqfwrqx/uutTW5T15vBOjr6SlrS8aFphpMaK2Q97YhMmUVEkuWCjhi0xC54nSvp1p4wbsm19tLeF2c25YE43iPbWarxrsCG7o3WbnGzbBSz1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784668179; c=relaxed/simple;
	bh=Ss0d/FtXt7qY2/K6XKwqXa2A1+8puGqwQg1fmKpIEHU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cn19GsZ/9phaCj2+SBFEjd6JxMNKKmM7MS1/t4G12oyed/362nOEv81aq4AZZYzPGqNzethVz971EdM8NEJnMACy8fAUpe8JEPXc9Ah3rsIbO2f+TsnMtuVbvvtPbT/5bsI4MxKqIkGDIXoICqUY7XbP/TgObd/xsd1GxfdBplE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id DCD0DC02A6;
	Tue, 21 Jul 2026 21:09:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 8967630;
	Tue, 21 Jul 2026 21:09:33 +0000 (UTC)
Date: Tue, 21 Jul 2026 17:09:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Baolin Liu <liubaolin12138@163.com>
Cc: almaz.alexandrovich@paragon-software.com, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 ntfs3@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 liubaolin12138@gmail.com, Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v1 v1 2/7] ntfs3: add namei tracepoints
Message-ID: <20260721170952.26f79352@gandalf.local.home>
In-Reply-To: <20260717032248.3318208-3-liubaolin12138@163.com>
References: <20260717032248.3318208-1-liubaolin12138@163.com>
	<20260717032248.3318208-3-liubaolin12138@163.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8967630
X-Stat-Signature: qojtcy4gzn5wrs17ydnuuimi48pyqbaf
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+tdfwZucz7oE5JLsF8N7x3CVcm/ofxZrs=
X-HE-Tag: 1784668173-947541
X-HE-Meta: U2FsdGVkX1/cC9ZmsEmqJ+zFElRipQF0/VCSqjaJA78e3OQ+ACEGOf0XB2xuNGcaNstQMrs47YLDmf7fVH5toZTZDBuDqCgJQnob0JMV/3f6kr12rQQ6dI5829u5q1coXVZ9k38EpYQKaW58uiZB9PUkvDTMJKJa/onodpcB9ALVmtPD0s5HgDdH6JX8FYWQW8q24fNNKEeHFPUqyIGWKAtLBqq0w313pZmAeBANLB374/mU1KTQlXrBeH12zYn/0W3CKWOONqpeh0M9Y0HdFDnmuAokepoeQtVHU3mObnQdagLsjYyjsec32CZhlbK8aE9EgX2y2KdDztnmA7meL2MyGeFmwCzU

On Fri, 17 Jul 2026 11:22:43 +0800
Baolin Liu <liubaolin12138@163.com> wrote:

> +TRACE_EVENT(ntfs3_lookup,
> +	TP_PROTO(struct inode *dir, struct dentry *dentry),
> +	TP_ARGS(dir, dentry),
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(unsigned long, parent_ino)
> +		__string(name, dentry->d_name.name)
> +		__field(unsigned int, name_len)
> +	),
> +	TP_fast_assign(
> +		__entry->dev = dir->i_sb->s_dev;
> +		__entry->parent_ino = dir->i_ino;
> +		__assign_str(name);
> +		__entry->name_len = dentry->d_name.len;

Is dentry->d_name.len not equal to strlen(dentry->d_name.name) + 1 ?

-- Steve


> +	),
> +	TP_printk("dev=(%d,%d) parent=%lu name=%s len=%u",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->parent_ino, __get_str(name),
> +		  __entry->name_len)
> +);
