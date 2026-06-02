Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A97E368D51;
	Tue,  2 Jun 2026 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417727; cv=none; b=QZGbH1WiP58zdVb2h9zvhl74GQtAnSwPoU1gicJ107LJOLyxM53IDEO6sAzSm/5cRVRTPH1OfiJqQqt3HVJCMLnj0MHWGjmmDFiZUb5WoS7g/ZBw97urCe6pD+uVBhwAFSZ5RNMq0dplISPYxLeN6xwZUfv1niNaI7iw6fS8Q7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417727; c=relaxed/simple;
	bh=j3+StrbEE9g63gUTuVFDRRY0pEYFW6hv/SzhYKlQuXg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8edym1gXXyQzZgVoPUAMG/P5ub/p2AH4gG6HofIzmRZaEWkcmCPUyfKaaXT+rJxKkW67uPYjuv31mvOjE6xhYEnbHZvVXwlLI5xTHcZ5o4iNOW57z1D7iimszV21OgakqypfDfQMnd+AdqQMqo3L/ftdcusl2MZz6Xx+gmvB50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 94FAE120A17;
	Tue,  2 Jun 2026 16:28:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id A135120030;
	Tue,  2 Jun 2026 16:28:35 +0000 (UTC)
Date: Tue, 2 Jun 2026 12:28:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: syzbot <syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [trace?] KASAN: use-after-free Write in
 ring_buffer_read_page
Message-ID: <20260602122829.4a91864f@gandalf.local.home>
In-Reply-To: <6a1ede7b.b4221f80.1326c5.0003.GAE@google.com>
References: <6a1ede7b.b4221f80.1326c5.0003.GAE@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A135120030
X-Stat-Signature: wdpjsg8wnusfk1o55gnfdcsu7kk6ujit
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Y4Hfo22B+artpyL5tz7woxnRjl9UfzQY=
X-HE-Tag: 1780417715-662554
X-HE-Meta: U2FsdGVkX1/5TMJOhcsc2WJHCw1gxHmVVUsBbQQYwv9F4FvIggaMwKCt63yz/5LefMHR7UtPgVJ2KqIGF2hSoEbkFTiOjRGtbWp2xayDE7I8uHttpHqO6DWrdYFLs+Gwgeh4OZ/qNX2cn6wCTYjTs2NNDUwLoROCLUC8kfX5D4ppWnpiYflgzaprrPPsp2AKZIYxSSHAWpR2BYyq/fjcZmoFGMEJ93iYfwAz81hfijEe76bMeFVFLCitF4Lx5E/LqZSmynUGEADn6GZiNBkfadUkZVuUI5q2TngCyM08JZYg3GiVU4OYQ//x2mRi+UZXP4WoiashQ4IwogxpeJc80VRQq/rXtTJrk8iQ87KV6GpJsg1raoGc+Xh2PUWpm4mzzjBFjqL0ljNwm0JYmDe+15Q9h+Od7h9/7Cug94NgG1ADrLvhJoyFQGbugp+MZAUw

On Tue, 02 Jun 2026 06:45:31 -0700
syzbot <syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com> wrote:

> syzbot found the following issue on:
> 
> HEAD commit:    e7ae89a0c97c Linux 7.1-rc5
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16f06e2e580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=58acee1ac5406016
> dashboard link: https://syzkaller.appspot.com/bug?extid=2dd9d02f60775ce5c1fb
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> 
> Unfortunately, I don't have any reproducer for this issue yet.

Looks like the test was doing something really weird to trigger this.
Without a reproducer, it's pretty much impossible to find out what
happened. Maybe AI could do it?

-- Steve
