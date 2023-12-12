Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FF7F5
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 Dec 2023 04:26:03 -0800 (PST)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-590caa98510so3344729eaf.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 12 Dec 2023 04:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702383963; x=1702988763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IB8C7XyMYQp9js6I3u3+HREkfx35O/WPhq62642Tn6U=;
        b=ftmJG6TLUM4DhUvekJu3QhJ8AfuKUASYUsv2nwt0MkPBrYddScjKTMWHNGeaSqZJAS
         J2JXhwutaeRRgoHwo0YCcrqplhjGm2wT8uTk0y0zLlh1BbQBK+J52ofWFrO69HLeBajN
         GoLpOlCO1vX7PcIi5oPnt+sEKBxhfb06uDqAmD8WqfRMF3f1l5CIIsDqI0A3IBXniVNZ
         j6gKjzH4G6h8e0KRXPgc/RejHZgXOofdTye8Nw55zSu+2bcB2fxDzwt+giBKWBDO6uQF
         aUSm8LsDJZ0wXTgY/TWgPfxoDnYxeHXWiR/XpcGqDA+NeHtJ+oImyCdEAkpVs2QPdtWv
         8EuA==
X-Gm-Message-State: AOJu0YyhGorMH+O0UlG4Zhc0zxPUWeCk7ziebVb4sebFBCxDPlGk/Drf
	GDm0wPOI06j3DK9lJzhDLDNoTgR7WfEUKNM1sFVoxeP+AJDd
X-Google-Smtp-Source: AGHT+IGFW5g3e6mA+LgWx2H/a9Cj4ZanQsFcd4iCXcghjcM04EBeoSn1GE5TRIxUvox8ZXjQik4AEtVZhFon/5TqCSJsXq9c+Xd+
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:3149:0:b0:58e:2832:83d5 with SMTP id
 v9-20020a4a3149000000b0058e283283d5mr2236155oog.1.1702383962863; Tue, 12 Dec
 2023 04:26:02 -0800 (PST)
Date: Tue, 12 Dec 2023 04:26:02 -0800
In-Reply-To: <000000000000e7765006072e9591@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060c000060c4f2747@google.com>
Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in task_fork_fair
From: syzbot <syzbot+1a93ee5d329e97cfbaff@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, brauner@kernel.org, 
	daniel@iogearbox.net, elic@nvidia.com, haoluo@google.com, jasowang@redhat.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	mst@redhat.com, netdev@vger.kernel.org, parav@nvidia.com, rostedt@goodmis.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit a3c06ae158dd6fa8336157c31d9234689d068d02
Author: Parav Pandit <parav@nvidia.com>
Date:   Tue Jan 5 10:32:03 2021 +0000

    vdpa_sim_net: Add support for user supported devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14c0b21ee80000
start commit:   2ebe81c81435 net, xdp: Allow metadata > 32
git tree:       bpf-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16c0b21ee80000
console output: https://syzkaller.appspot.com/x/log.txt?x=12c0b21ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8715b6ede5c4b90
dashboard link: https://syzkaller.appspot.com/bug?extid=1a93ee5d329e97cfbaff
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148b2632e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aae88ee80000

Reported-by: syzbot+1a93ee5d329e97cfbaff@syzkaller.appspotmail.com
Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported devices")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
